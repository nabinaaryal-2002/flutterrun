import 'package:flutter/material.dart';
import 'package:fluttersample1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/models/book.dart';

// #F1F5F9


class Homepage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final actualHeight = height - 50 - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    print(height);
    print(width);

    return Scaffold(
      // backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        // backgroundColor: Colors.pink.withOpacity(0.9),
        // backgroundColor: Color.fromRGBO(20, 90, 100, 0.5),
        backgroundColor: appColor,
        elevation: 0,
        title: Text('Hi Roshan,',style: TextStyle(color: blackColor)),
        actions: [
          Icon(Icons.search,color: Colors.black, size: 30,),
          SizedBox(width: 10,),
          Icon(Icons.notifications_active_outlined,color: blackColor, size: 30,),
        ],

        // toolbarHeight: 500,
      ),
      body: Column(
        children: [
          Container(
            height: 250.h,
            width: double.infinity,
            child: Image.asset('assets/images/book.jpg',fit: BoxFit.cover,),
          ),
          SizedBox(height: 15.h,),
          Container(
            height: 240.h,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index){
                  return Container(
                    width: 370.w,
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Image.network(books[index].imageUrl, width: 120.w, height: 240.h, fit: BoxFit.cover,),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(books[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 22.h),
                                    child: Text(books[index].detail, maxLines: 4,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(books[index].rating, style: TextStyle(fontSize: 17.sp),),
                                      Text(books[index].genres, style: TextStyle(color: Colors.blueGrey, fontSize: 20.sp),)
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
            ),
          ),


        ],
      )

        // margin: EdgeInsets.only(top: 20, left: 20),
        // margin: EdgeInsets.all(50),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        // padding: EdgeInsets.only(top: 20, left: 20),
        // padding:  EdgeInsets.all(50),
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),


      //   width: double.infinity,
      //   // width: 200,
      //
      //
      //   child:Column(
      //     // crossAxisAlignment: CrossAxisAlignment.center,
      //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children:[
      //
      //       Container(
      //         height: actualHeight * 0.25,
      //         width: double.infinity,
      //         color: Colors.pink,
      //         child: LayoutBuilder(
      //             builder: (context, constraints) {
      //               return Row(
      //                 children: [
      //                   Container(
      //                     color: Colors.amber,
      //                     width: constraints.maxWidth * 0.5,
      //                     height: constraints.maxHeight ,
      //                   )
      //                 ],
      //               );
      //             }
      //         ),
      //       ),
      //       Container(
      //         height: actualHeight*0.25,
      //         width: double.infinity,
      //         color: Colors.blueAccent,
      //         child: Text('hello1'),
      //       ),
      //       Container(
      //         height: actualHeight*0.25,
      //         width: double.infinity,
      //         color: Colors.greenAccent,
      //         child: Text('hello2'),
      //       ),
      //     ]
      //   )
      // ),
      //


    );
  }
}
