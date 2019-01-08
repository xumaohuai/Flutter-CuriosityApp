import 'BaseModuleWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';

Widget ListImageRight(
    BuildContext context, Feed feed) {
  Widget widget;
  widget = new Row(
        children: <Widget>[
          Container(
            width: 200,
            height: 120,
            margin: EdgeInsets.all(0),
            child: Column(
              children: <Widget>[
                Container(
                  child: TitleLabel(context, feed.post.title),
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
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
      );
  return widget;
}