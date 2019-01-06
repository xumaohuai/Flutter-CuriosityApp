import 'package:flutter/material.dart';
import 'model/model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_curiosity_app/widget/ListImageRight.dart';
import 'widget/SwiperWidget.dart';
import 'package:flutter_curiosity_app/widget/NewsListWidget.dart';
import 'package:flutter_curiosity_app/widget/ListImageTop.dart';
import 'package:flutter_curiosity_app/widget/ActivityWidget.dart';
import 'package:flutter_curiosity_app/tool/WidgetUtils.dart';

class News extends StatefulWidget {
  @override
  String url;
  News({Key key, @required this.url}) : super(key: key);
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
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
  String url;
  dynamic lastKey = '0';
  List<dynamic> dataList = [];
  List<MyColumn> columnList = [];
  List<MyBanner> banners = [];
  void getData()async{
    if (lastKey == '0'){
      dataList = [];
    }
    Dio dio = new Dio();
    Response response = await dio.get("$url$lastKey.json");
    Reslut reslut = Reslut.fromJson(response.data);
    if(!reslut.response.hasMore){
      return;
    }
    if(reslut.response.columns != null) {
      columnList = reslut.response.columns;
    }
    lastKey = reslut.response.lastKey;
    setState(() {
      if (reslut.response.banners != null){
        banners = reslut.response.banners;
      }
      dataList.addAll(reslut.response.feeds);
    });
  }
  void getColunmData()async{
    Dio dio = new Dio();
    Response response = await dio.get('http://app3.qdaily.com/app3/columns/index/${columnList[0].id}/0.json');
    Reslut reslut = Reslut.fromJson(response.data);
    setState(() {
      dataList.insert(columnList[0].location,
          {'id':columnList[0].id,'lastKey':reslut.response.lastKey,'feedList':reslut.response.feeds,'showType':columnList[0].showType});
      columnList.removeAt(0);
    });
  }

  _getListCount() {
      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (dataList.length > 0) ? dataList.length + 2 : dataList.length + 1;
    }
  final ScrollController _scrollController = new ScrollController();
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
      color: Colors.yellow,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _getListCount(),
        controller: _scrollController,
        itemBuilder: (context,index){
          if(columnList.length > 0 && index == columnList[0].location){
            getColunmData();
          }
          if(index == 0){
            return SwiperWidget(context, banners);
          }else if(index < dataList.length + 1){
            return WidgetUtils.GetListWidget(context, dataList[index - 1]);
          }else {
            return _buildProgressIndicator();
          }
        },
        separatorBuilder: (context,idx){
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
  /// 不需要加载

  return new Padding(
    padding: const EdgeInsets.all(20.0),
    child: new Center(
      child: bottomWidget,
    ),
  );
}