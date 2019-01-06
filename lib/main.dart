import 'package:flutter/material.dart';
import 'news.dart';

class TabbedAppBarSample extends StatelessWidget {
  var titleList = ['NEWS','LABS'];
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: new DefaultTabController(
        length: titleList.length,
        child: new Scaffold(
            appBar: new AppBar(
              elevation: 0.0,//导航栏下面那根线
              title: new TabBar(
              isScrollable: false,
              unselectedLabelColor: Colors.black26,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 18),
              indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4.0,
                indicatorColor: Colors.yellow,
              indicatorPadding: EdgeInsets.only(bottom: 1),
              tabs: titleList.map((String text) {
                return new Tab(
                  text: text,
                );
              }).toList(),
            ),
          ),
              body:TabBarView(children: [News(url: 'http://app3.qdaily.com/app3/homes/index_v2/'),News(url: 'http://app3.qdaily.com/app3/papers/index/')]) ,
        ),
      ),
    );
  }
}




void main() {
  runApp(new TabbedAppBarSample());
}