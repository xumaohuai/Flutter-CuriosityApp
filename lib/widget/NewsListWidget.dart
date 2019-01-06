import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'BaseModuleWidget.dart';

Widget NewsListWidget(BuildContext context,Feed feed){
  return Column(
    children: <Widget>[
      TitleWidget(context),
      NewsFirstLineWidget(context, feed.newsList[0].description, feed.image),
      Container(height: 10,),
      NewsLineWidget(context, feed.newsList[1].description),
      Container(
        height: 0.8,
//        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        color: Color.fromARGB(50,183, 187, 197),
      ),
      NewsLineWidget(context, feed.newsList[2].description),
      NewsListBottomWidget(context,feed.post),
    ],
  );
}

Widget TitleWidget(BuildContext context){
  return Row(
    children: <Widget>[
      Container(
        child: Image.asset('qdaily.png',fit: BoxFit.fitWidth,width: 25,height: 25,),
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: TitleLabel(context, '大公司头条',),
      )
    ],
  );
}

Widget NewsFirstLineWidget(BuildContext context,String title,String imageStr){
  return Row(
    children: <Widget>[
        Container(
        width: 40,
        height: 40,
        child: Image.asset('yellowDot.png',fit:BoxFit.fitWidth, width: 30,height: 30,),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      ),
      Container(
        width: 200,
        height: 40,
        child: DescriptionLabel(context, title, fontSize: 13),
      ),
      Expanded(
        child:  Container(
//          margin: EdgeInsets.all( 10),
//          width: 140,
          height: 60,
          child: Image.network(imageStr,fit: BoxFit.fitHeight,),
        ),
      ),
    ],
  );
}
Widget NewsLineWidget(BuildContext context,String title){
  return Row(
    children: <Widget>[
      Container(
        width: 40,
        height: 30,
        child: Image.asset('yellowDot.png',fit: BoxFit.fitWidth,),
        padding: EdgeInsets.only(bottom: 12),
      ),
      Expanded(
        child: Container  (
          padding: EdgeInsets.only(right: 20),
          height: 30,
          child: DescriptionLabel(context, title,fontSize: 13),
          margin: EdgeInsets.only(right: 10),
        ),
      )

    ],
  );
}

Widget NewsListBottomWidget(BuildContext context,Post post){
    return Row(
      children: <Widget>[
        Container(
          child: ListBottomWidget(context,post),
          padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: DescriptionLabel(context, '查看详情>>'),
            padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
          ),
        )
      ],
    );
}
