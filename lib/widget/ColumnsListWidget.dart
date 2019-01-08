import 'package:flutter/material.dart';
import 'ActivityWidget.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'BaseModuleWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_curiosity_app/tool/CommonUtils.dart';
import 'package:flutter_curiosity_app/tool/WidgetUtils.dart';
import 'package:flutter_curiosity_app/ColumnsDetail.dart';

class ColumnsListWidget extends StatefulWidget {

  int id;
  int showType;
  ColumnsListWidget({Key key, @required this.id,this.showType}) : super(key: key);
  @override
  _ColumnsListWidgetState createState() => _ColumnsListWidgetState();
}

class _ColumnsListWidgetState extends State<ColumnsListWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Feed> feedList = [];
  int lastKey = 0;
  int id ;
  int showType;
  final ScrollController _scrollController = new ScrollController();
  void getColunmData()async{
    Dio dio = new Dio();
    Response response = await dio.get('http://app3.qdaily.com/app3/columns/index/$id/$lastKey.json');
    Reslut reslut = Reslut.fromJson(response.data);
    if(!reslut.response.hasMore){
      return;
    }
    setState(() {
      lastKey = reslut.response.lastKey;
      feedList.addAll(reslut.response.feeds);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.id = widget.id;
    this.showType = widget.showType;
    print('初始化');
    getColunmData();
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            setState(() {
              getColunmData();
            });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ColumnsContainerWidget(context, feedList,_scrollController,showType,widget.id);
  }
}


Widget ColumnsContainerWidget(BuildContext context,List<Feed> feedList,ScrollController scrollController,int showType,int id){
  if(feedList.length == 0){
    return Container();
  }
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 320,
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 50,
              child: ActivityTitleWidget(context, feedList[0].post.column.icon, feedList[0].post.column.name),
            ),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => ColumnsDetail(id: id,),
                  )
              );
            },
          ),
          Container(
            child: ColumnstWidget(feedList,scrollController,showType),
          )
        ],
      ),
  );
}

Widget ColumnstWidget(List<Feed> feedList,ScrollController scrollController,int showType){
    return Flexible(
        child: ListView.separated(
          controller: scrollController,
          padding: new EdgeInsets.symmetric(horizontal: 12.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index) {
            if(showType == 1){
              return ColumnsTypeOneTile(context, feedList[index]);
            }
            return ColumnsTypeTwoTile(context, feedList[index]);
        },
        separatorBuilder: (context,idx){
          return Container(
            width: 8,
            color: Colors.white,
          );
        },
        itemCount: feedList.length,
        )
    );
}

Widget ColumnsTypeOneTile(BuildContext context, Feed feed){
  return GestureDetector(
    onTap: (){
      WidgetUtils.pushToCuriosityWebView(context, feed.post.id);
    },
    child: Container(
      decoration: new BoxDecoration(
        border: new Border.all(width: 0.5, color: Color.fromARGB(50,183, 187, 197)),
      ),
      width: 270,
      height: 245,
      child: Column(
        children: <Widget>[
          Container(
            child: Image.network(feed.image,width: 150,fit: BoxFit.fitWidth,),
            height: 140,
            width: 270,
          ),
          Container(
            child: TitleLabel(context, feed.post.title,fontSize: 12,maxLines: 2),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          ),
          Container(
            child: DescriptionLabel(context, feed.post.description,fontSize: 12,maxLines: 2),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          ),
          Expanded(
            child: Container(
              child:  Row(
                mainAxisSize:MainAxisSize.min,
                children: <Widget>[
                  IconText(context, feed.post.commentCount, 'feedComment.png'),
                  IconText(context, feed.post.praiseCount, 'feedPraise.png'),
                  Padding(padding: EdgeInsets.all(5),),
                  DescriptionLabel(context, CommonUtils.getNewsTimeStr(feed.post.publishTime * 1000)),
                ],
              ),
              padding: EdgeInsets.fromLTRB(8, 0, 0, 5),
              alignment: Alignment.bottomLeft,
            ),
          )
        ],
      ),
    ),
  );
}

Widget ColumnsTypeTwoTile(BuildContext context, Feed feed){
  return GestureDetector(
      onTap: (){
    WidgetUtils.pushToCuriosityWebView(context, feed.post.id);
  },
   child: Container(
    decoration: new BoxDecoration(
      border: new Border.all(width: 0.5, color: Color.fromARGB(50,183, 187, 197)),
    ),
    width: 150,
    height: 245,
    child: Column(
      children: <Widget>[
        Container(
          child: Image.network(feed.image,fit: BoxFit.fitWidth,),
          height: 140,
          width: 150,
        ),
        Container(
          child: TitleLabel(context, feed.post.title,fontSize: 12,maxLines: 2),
          padding: EdgeInsets.only(top: 20)
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child:  Row(
              mainAxisSize:MainAxisSize.min,
              children: <Widget>[
                IconText(context, feed.post.commentCount, 'feedComment.png'),
                IconText(context, feed.post.praiseCount, 'feedPraise.png'),
              ],
            ),
            padding: EdgeInsets.only(bottom: 30),
          ),
        )
      ],
    ),
  )
  );
}