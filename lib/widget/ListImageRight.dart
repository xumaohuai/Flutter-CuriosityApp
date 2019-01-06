import 'BaseModuleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'package:flutter_curiosity_app/curiosityWebView.dart';
import 'package:dio/dio.dart';

Widget ListImageRight(
    BuildContext context, Feed feed) {
  Widget widget;
  widget = new GestureDetector(
    onTap: ()async{
      Dio dio = new Dio();
      Response response = await dio.get("http://app3.qdaily.com/app3/articles/detail/${feed.post.id}.json");
      String htmlBody = Reslut.fromJson(response.data).response.article.body;
      print('body = $htmlBody');
      Navigator.push(context, MaterialPageRoute(

          builder: (context)=>CuriosityWebView( htmlBody:htmlBody),
      )
      );
    },
      child: new Row(
        children: <Widget>[
          Container(
            width: 200,
            height: 120,
            margin: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  child: TitleLabel(context, feed.post.title),
                  height: 70,
                  padding: const EdgeInsets.all(10),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      alignment: Alignment.bottomLeft,
                      child: ListBottomWidget(context, feed.post)
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:  Container(
              margin: EdgeInsets.only(left: 0),
//              width: 170,
              height: 120,
              child: Image.network(feed.image,fit: BoxFit.fitHeight,),
            ),
          ),
        ],
      )
  );
  return widget;
}