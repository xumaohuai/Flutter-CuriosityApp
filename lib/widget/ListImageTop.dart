import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';
import 'BaseModuleWidget.dart';

Widget ListImageTop(BuildContext context,Feed feed){
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.network(feed.image,fit: BoxFit.fitWidth,),
          height: 170,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TitleLabel(context, feed.post.title),
          margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: DescriptionLabel(context, feed.post.description),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
        ),
        Container(
          child: ListBottomWidget(context, feed.post),
          margin: EdgeInsets.fromLTRB(15, 0, 0, 13),
        )
      ],
    );
}