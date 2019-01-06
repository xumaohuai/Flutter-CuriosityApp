import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'package:flutter_curiosity_app/widget/NewsListWidget.dart';
import 'package:flutter_curiosity_app/widget/ListImageTop.dart';
import 'package:flutter_curiosity_app/widget/ActivityWidget.dart';
import 'package:flutter_curiosity_app/widget/ListImageRight.dart';
import 'package:flutter_curiosity_app/curiosityWebView.dart';
import 'package:dio/dio.dart';
import 'package:flutter_curiosity_app/widget/ColumnsListWidget.dart';

///http://app3.qdaily.com/app3/columns/index/8/0.json  横向列表图片卡片
///http://app3.qdaily.com/app3/columns/index/59/0.json 横向书本图片列表
class WidgetUtils {
  static pushToCuriosityWebView(BuildContext context,int id)async{
    Dio dio = new Dio();
    Response response = await dio.get(
        "http://app3.qdaily.com/app3/articles/detail/${id}.json");
    String htmlBody = Reslut.fromJson(response.data).response.article.body;
    print('body = $htmlBody');
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CuriosityWebView(htmlBody: htmlBody),
    )
    );
  }
  static Widget GetListWidget(BuildContext context, dynamic data) {
    Widget widget;
    if(data.runtimeType == Feed) {
      if (data.indexType == 12) {
        widget = NewsListWidget(context, data);
      } else if (data.type == 2) {
        widget = ListImageTop(context, data);
      } else if (data.type == 0) {
        widget = ActivityWidget(context, data);
      } else if (data.type == 1) {
        widget = ListImageRight(context, data);
      }
    }else{
      widget = ColumnsListWidget(feedList: data['feedList'],lastKey: data['lastKey'],id: data['id'],showType: data['showType'],);
    }
    return GestureDetector(
      onTap: (){
        WidgetUtils.pushToCuriosityWebView(context, data.post.id);
      },
      child: widget,
    );
  }
}

