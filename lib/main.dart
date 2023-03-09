
import 'package:flutter/material.dart';
import 'package:fluttersample1/constants/colors.dart';
import 'package:fluttersample1/view/home_page.dart';
import 'package:flutter/services.dart';




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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    //     theme: ThemeData().copyWith(
    //     backgroundColor: Colors, green,
    //     buttonTheme: ButtonThemData().copyWith(
    //       buttonColor: Colors.pink
    //     )
    // ),

    );
  }
}
