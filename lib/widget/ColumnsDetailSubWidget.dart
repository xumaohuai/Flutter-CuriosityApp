import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';

Widget ImageTitleWidget(BuildContext context,MyResponse myResponse){
    if(myResponse == null){
      return Container();
    }
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment(1, 0.8),
            children: <Widget>[
              Image.network(myResponse.column.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 380,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: NameLabelWidget(myResponse.column),
              ),
            ],
          ),
          subscriberNumberWidget(context,myResponse.column.subscriberNum),
          SubscriberGridView(context, myResponse.subscribers),
        ],
      ),
    );

}

Widget NameLabelWidget(MyColumn column){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(column.name,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              )
          ),
          padding: EdgeInsets.only(bottom: 15),
        ),
        Container(
          width: 220,
          child: Text(column.description,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 240, 240, 240),
                fontWeight: FontWeight.w300,
              )
          ),
          padding: EdgeInsets.only(bottom: 15),
        ),
        Container(
          child:  Image.asset('detailAdd.png',width: 50,height: 50,)
        )
      ],
    );
}

Widget subscriberNumberWidget(BuildContext context,int subScriberNum){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 7),
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 0.5,
                color: Color.fromARGB(50,180, 180, 180),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text('${subScriberNum} 人订阅了本栏目',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromARGB(200, 180, 180, 180),
                  ),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 7),
              child: Container(
                height: 0.5,
                color: Color.fromARGB(50,180, 180, 180),
              ),
            ),
          ),
        ],
      ),
    );
}

Widget SubscriberGridView(BuildContext context, List<Author> subscribers){
  return Container(
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
    width: MediaQuery.of(context).size.width,
    height: 110,
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 6,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
      children: List.generate(12, (index){
        return Container(
        padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(subscribers[index].avatar),
          ),
//          child: Image.network(subscribers[index].avatar,fit: BoxFit.fill,),
        );
      })
    ),
  );
}