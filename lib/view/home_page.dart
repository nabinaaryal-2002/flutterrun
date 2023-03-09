import 'package:flutter/material.dart';
import 'package:fluttersample1/constants/colors.dart';


// #F1F5F9


class Homepage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final height = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        // backgroundColor: Colors.pink.withOpacity(0.9),
        // backgroundColor: Color.fromRGBO(20, 90, 100, 0.5),
        backgroundColor: appColor,
        elevation: 0,
        title: Text('Hi john,',style: TextStyle(color: blackColor)),
        actions: [
          Icon(Icons.search,color: Colors.black, size: 30,),
          SizedBox(width: 10,),
          Icon(Icons.notifications_active_outlined,color: blackColor, size: 30,),
        ],

        // toolbarHeight: 500,
      ),



    );
  }
}
