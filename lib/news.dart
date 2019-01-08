import 'package:flutter/material.dart';
import 'model/model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'widget/SwiperWidget.dart';
import 'package:flutter_curiosity_app/tool/WidgetUtils.dart';

class News extends StatefulWidget {
  @override
  String url;
  News({Key key, @required this.url}) : super(key: key);
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
      url = widget.url;
      getData();
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }
  final ScrollController _scrollController = new ScrollController();
  String url;
  dynamic lastKey = '0';
  List<dynamic> dataList = [];
  List<MyBanner> banners = [];
  void getData()async{
    if (lastKey == '0'){
      dataList = [];//下拉刷新的时候将DataList制空
    }
    Dio dio = new Dio();
    Response response = await dio.get("$url$lastKey.json");
    Reslut reslut = Reslut.fromJson(response.data);
    if(!reslut.response.hasMore){
      return;//如果没有数据就不继续了
    }
    lastKey = reslut.response.lastKey;//更新lastkey
    setState(() {
      if (reslut.response.banners != null){
        banners = reslut.response.banners;//给轮播图赋值
      }
      List<dynamic>data = [];
      data.addAll(reslut.response.feeds);
      if(reslut.response.columns != null) {
        reslut.response.columns.forEach((MyColumn colunm) {
          data.insert(colunm.location, {'id': colunm.id,
            'showType': colunm.showType});
        });
      }
      dataList.addAll(data);//给数据源赋值
    });
  }

  _getListCount() {
      ///如果有数据,最上面是轮播图最下面是加载loading动画，需要对列表数据总数+2
      return (dataList.length > 0) ? dataList.length + 2 : dataList.length + 1;
    }
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      lastKey = '0';
      getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:(()=> _handleRefresh()),
      color: Colors.yellow,//刷新控件的颜色
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _getListCount(),//item个数
        controller: _scrollController,//用于监听是否滑到最底部
        itemBuilder: (context,index){
          if(index == 0){
            return SwiperWidget(context, banners);//如果是第一个,则展示banner
          }else if(index < dataList.length + 1){
            return WidgetUtils.GetListItemWidget(context, dataList[index - 1]);//展示数据
          }else {
            return _buildProgressIndicator();//展示加载loading框
          }
        },
        separatorBuilder: (context,idx){//分割线
          return Container(
            height: 5,
            color: Color.fromARGB(50,183, 187, 197),
          );
        },
      ),
    );
  }
  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
///上拉加载更多
Widget _buildProgressIndicator() {
  ///是否需要显示上拉加载更多的loading
  Widget bottomWidget = new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    ///loading框
    new SpinKitThreeBounce(color: Color(0xFF24292E)),
    new Container(
      width: 5.0,
    ),
  ]);
  return new Padding(
    padding: const EdgeInsets.all(20.0),
    child: new Center(
      child: bottomWidget,
    ),
  );
}