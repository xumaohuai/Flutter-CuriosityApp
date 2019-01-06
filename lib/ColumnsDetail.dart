import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/widget/ColumnsDetailSubWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'package:flutter_curiosity_app/widget/ColumnsListWidget.dart';
import 'package:flutter_curiosity_app/widget/ListImageRight.dart';

class ColumnsDetail extends StatefulWidget {
  int id;
  @override
  _ColumnsDetailState createState() => _ColumnsDetailState();
  ColumnsDetail({Key key,@required this.id}) : super(key: key);
}

class _ColumnsDetailState extends State<ColumnsDetail> {
  int id;
  int lastKey = 0;
  List<Feed> feedList = [];
  MyResponse infoResponse;
  final ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    getInfoData();
    getData();
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }
  ///http://app3.qdaily.com/app3/columns/index/29/0.json
  void getInfoData()async{
    Dio dio = new Dio();
    Response response = await dio.get("http://app3.qdaily.com/app3/columns/info/$id.json");
    Reslut reslut = Reslut.fromJson(response.data);

    setState(() {
      infoResponse = reslut.response;
    });
  }
  void getData()async{
    Dio dio = new Dio();
    Response response = await dio.get("http://app3.qdaily.com/app3/columns/index/$id/$lastKey.json");
    Reslut reslut = Reslut.fromJson(response.data);
    lastKey = reslut.response.lastKey;
    setState(() {
      print('${reslut.response.feeds.length}');
      feedList.addAll(reslut.response.feeds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(vertical: 20),
//        shrinkWrap: true,
        children: <Widget>[
          ImageTitleWidget(context, infoResponse),
//          Container(),
//          ColumnsDetailTypeTwo(context,feedList),
          ColumnsDetailTile(context,feedList,infoResponse),
        ],
      ),
      ),
    );
  }
}

Widget ColumnsDetailTile(BuildContext context,List<Feed> feedList,MyResponse infoResponse){
  if(feedList.length == 0 || infoResponse == null){
    return Container();
  }
  print('showtype = ${infoResponse.column.showType} --- ${feedList.length}');
  if(infoResponse.column.showType == 1){
    return ColumnsDetailTypeOne(context, feedList);
  }
  return ColumnsDetailTypeTwo(context, feedList);
}


Widget ColumnsDetailTypeOne(BuildContext context,List<Feed> feesList){
  return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: feesList.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return ListImageRight(context, feesList[index]);
      },
      separatorBuilder: (context,idx){
        return Container(
          height: 5,
          color: Color.fromARGB(50,183, 187, 197),
        );
      },
  );
}


Widget ColumnsDetailTypeTwo(BuildContext context,List<Feed> feesList){
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 0.612,
        padding: new EdgeInsets.symmetric(horizontal: 20.0),
        children: feesList.map((Feed feed) {
          return  ColumnsTypeTwoTile(context, feed);
        }).toList()
 );
}


