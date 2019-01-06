import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_curiosity_app/model/model.dart';

Widget SwiperWidget(BuildContext context,List<MyBanner> bannerList){
      Widget widget;
      if(bannerList.length == 0){
        return Container();
      }
      DotSwiperPaginationBuilder builder = DotSwiperPaginationBuilder(
        color: Colors.white,//未选中圆点颜色
        activeColor: Colors.yellow,//选中圆点颜色
        size:7,//未选中大小
        activeSize: 7,//选中圆点大小
        space: 5//圆点间距
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
