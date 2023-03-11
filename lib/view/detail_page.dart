import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/models/book.dart';


class DetailPage extends StatelessWidget {

  final Book book;

  DetailPage(this.book);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
           Image.network(book.imageUrl),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(book.title),
                      Column(
                        children: [
                          Text(book.rating),
                          Text(book.genres),
                        ],
                      )
                    ],


                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(book.detail),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                         // maximumSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                            onPressed: (){},
                            child: Text('Read Book')
                        ),
                        SizedBox(width: 10.w,),
                        OutlinedButton(
                            onPressed: (){},
                            child: Text('More Info')
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
