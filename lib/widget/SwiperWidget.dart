import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';

Widget SwiperWidget(BuildContext context,List<MyBanner> bannerList){
      Widget widget;
      if(bannerList.length == 0){
        return Container();
      }
      DotSwiperPaginationBuilder builder = DotSwiperPaginationBuilder(
        color: Colors.white,
        activeColor: Colors.yellow,
        size:7,
        activeSize: 7,
        space: 5
      );
         widget = bannerList.length > 0 ? new Swiper(
        itemCount: bannerList.length,
        loop: true,
        itemBuilder: (BuildContext context,int index){
          return new Image.network(bannerList[index].image,fit: BoxFit.cover,);
        },
        pagination: new SwiperPagination(
          builder: builder,
        ),
      ) : Container(
           height: 200,
         );
      return Container(
        height: 200,
        child: widget,
      );
}
