
import 'package:flutter/material.dart';
import 'package:fluttersample1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/view/home_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




void main(){
SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor:appColor
    )
);
runApp(Home());
}


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
 return ScreenUtilInit(
   designSize: const Size(411, 866),
   minTextAdapt: true,
   builder: (context , child) {
     return GetMaterialApp(
       debugShowCheckedModeBanner: false,
       home: child,
     );
   },
   child: Homepage(),
 );

  }
}
