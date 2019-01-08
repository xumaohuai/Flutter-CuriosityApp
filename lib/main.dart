import 'package:flutter/material.dart';
import 'news.dart';

class TabbedAppBarMain extends StatelessWidget {
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
              isScrollable: false,//是否可滑动
              unselectedLabelColor: Colors.black26,//未选中按钮颜色
              labelColor: Colors.black,//选中按钮颜色
              labelStyle: TextStyle(fontSize: 18.0),//文字样式
              indicatorSize: TabBarIndicatorSize.label,//滑动的宽度是根据内容来适应,还是与整块那么大(label表示根据内容来适应)
                indicatorWeight: 4.0,//滑块高度
                indicatorColor: Colors.yellow,//滑动颜色
              indicatorPadding: EdgeInsets.only(bottom: 1.0),//与底部距离为1
              tabs: titleList.map((String text) {//tabs表示具体的内容,是一个数组
                return new Tab(
                  text: text,
                );
              }).toList(),
            ),
          ),
              //body表示具体展示的内容
              body:TabBarView(children: [News(url: 'http://app3.qdaily.com/app3/homes/index_v2/'),News(url: 'http://app3.qdaily.com/app3/papers/index/')]) ,
        ),
      ),
    );
  }
}




void main() {
  runApp(new TabbedAppBarMain());
}