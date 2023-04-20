import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:get/get.dart';
import '../common/snackShow.dart';
import '../constants/colors.dart';
import '../providers/crud_provider.dart';
import '../providers/toggle_provider.dart';



class CreatePage extends  ConsumerWidget {

  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();


  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, ref) {

    ref.listen(crudProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'succesfully added');
        Get.back();
      }
    });

    final image = ref.watch(imageProvider);
    final crud = ref.watch(crudProvider);
    final auth = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.fireplace_rounded,color: Color(0xFFFFFCB2B),),
            SizedBox(width: 10.w,),
            Text('FireChat',style: TextStyle(fontSize: 25.sp, color: Color(0xFFFFFCB2B) ),),
          ],
        ),
      ),

      body:  Padding(
        padding:  EdgeInsets.only(top: 70.h),
        child: Form(
          key: _form,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Create Page', style: TextStyle(fontSize: 25.sp,
                    color: primary,
                    fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    // color: Colors.red,
                    width: 250.w,
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              controller: titleController,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'title is required';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),

                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Title',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'detail is required';
                                }else if(val.length > 500){
                                  return 'minimum character exceed';
                                }
                                return null;
                              },
                              controller: detailController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Detail',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 8),
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'price is required';
                                }else if(val.length > 50){
                                  return 'minimum character exceed';
                                }
                                return null;
                              },
                              controller: priceController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  // fillColor: Colors.black,
                                  filled: true,
                                  hintText: 'Price',
                                  hintStyle: TextStyle(color: Colors.grey)
                              )
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            ref.read(imageProvider.notifier).pickAnImage();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            height: 150.h,
                            width: 250.w,
                            color: Colors.white,
                            child: image == null ? Center(child: Text('select an image', style: TextStyle(color: Colors.black),)) : Image.file(File(image.path)),
                          ),
                        ),

                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.amber.shade500,
                                foregroundColor: Colors.black
                            ),
                            onPressed: () {
                              _form.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if(_form.currentState!.validate()){

                                if(image == null){
                                  SnackShow.showFailure(context, 'please select an image');
                                }else{
                                  ref.read(crudProvider.notifier).addPost(
                                      title: titleController.text.trim(),
                                      detail: detailController.text.trim(),
                                      price: int.parse(priceController.text.trim()),
                                      token: auth.user!.token,
                                      image: image
                                  );

                                }


                              }



                            },
                            child:crud.isLoad ? Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )): Text('Submit', style: TextStyle(fontSize: 20.sp),))
                      ],
                    ),
                  ),
                ),


              ],

            ),
          ),
        ),
      ),
    );

  }
}





















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttersample1/providers/auth_provider.dart';
// import 'package:get/get.dart';
// import '../common/snackShow.dart';
// import '../constants/colors.dart';
// import '../providers/crud_provider.dart';
// import '../providers/toggle_provider.dart';
// import 'package:fluttersample1/providers/crud_provider.dart';
//
//
// class CreatePage extends  ConsumerWidget {
//
//   final titleController = TextEditingController();
//   final detailController = TextEditingController();
//   final priceController = TextEditingController();
//
//
//   final _form = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context, ref) {
//
//     ref.listen(crudProvider, (previous, next) {
//       if(next.errorMessage.isNotEmpty){
//         SnackShow.showFailure(context, next.errorMessage);
//       }else if(next.isSuccess){
//         SnackShow.showSuccess(context, 'succesfully added');
//         Get.back();
//       }
//     });
//
//     final image = ref.watch(imageProvider);
//     final crud = ref.watch(crudProvider);
//     final auth = ref.watch(authProvider);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: blackColor,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Icon(Icons.fireplace_rounded,color: Color(0xFFFFFCB2B),),
//             SizedBox(width: 10.w,),
//             Text('Shop App',style: TextStyle(fontSize: 25.sp, color: Color(0xFFFFFCB2B) ),),
//           ],
//         ),
//       ),
//
//       body:  Padding(
//         padding:  EdgeInsets.only(top: 70.h),
//         child: Form(
//           key: _form,
//           child: Container(
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text('Create Page', style: TextStyle(fontSize: 25.sp,
//                     color: primary,
//                     fontWeight: FontWeight.bold),),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all()
//                     ),
//                     // color: Colors.red,
//                     width: 250.w,
//                     child: Column(
//                       children: [
//
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 20, left: 10, right: 10, bottom: 8),
//                           child: TextFormField(
//                               controller: titleController,
//                               validator: (val){
//                                 if(val!.isEmpty){
//                                   return 'title is required';
//                                 }
//                                 return null;
//                               },
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 10),
//                                   enabledBorder: OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//
//                                   // fillColor: Colors.black,
//                                   filled: true,
//                                   hintText: 'Title',
//                                   hintStyle: TextStyle(color: Colors.grey)
//                               )
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10, left: 10, right: 10, bottom: 8),
//                           child: TextFormField(
//                               validator: (val){
//                                 if(val!.isEmpty){
//                                   return 'detail is required';
//                                 }else if(val.length > 500){
//                                   return 'minimum character exceed';
//                                 }
//                                 return null;
//                               },
//                               controller: detailController,
//                               decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 10),
//                                   enabledBorder: OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   // fillColor: Colors.black,
//                                   filled: true,
//                                   hintText: 'Detail',
//                                   hintStyle: TextStyle(color: Colors.grey)
//                               )
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10, left: 10, right: 10, bottom: 8),
//                           child: TextFormField(
//                            keyboardType: TextInputType.number,
//                               validator: (val){
//                                 if(val!.isEmpty){
//                                   return 'price is required';
//                                 }else if(val.length > 500){
//                                   return 'minimum character exceed';
//                                 }
//                                 return null;
//                               },
//                               controller: priceController,
//                               decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 10),
//                                   enabledBorder: OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   // fillColor: Colors.black,
//                                   filled: true,
//                                   hintText: 'Price',
//                                   hintStyle: TextStyle(color: Colors.grey)
//                               )
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             ref.read(imageProvider.notifier).pickAnImage();
//                           },
//                           child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 15),
//                             height: 150.h,
//                             width: 250.w,
//                             color: Colors.white,
//                             child: image == null ? Center(child: Text('select an image', style: TextStyle(color: Colors.black),)) : Image.file(File(image.path)),
//                           ),
//                         ),
//
//                         TextButton(
//                             style: TextButton.styleFrom(
//                                 backgroundColor: Colors.amber.shade500,
//                                 foregroundColor: Colors.black
//                             ),
//                             onPressed: () {
//                               _form.currentState!.save();
//                               FocusScope.of(context).unfocus();
//                               if(_form.currentState!.validate()){
//
//                                 if(image == null){
//                                   SnackShow.showFailure(context, 'please select an image');
//                                 }else{
//                                   ref.read(crudProvider.notifier).addPost(
//                                       title: titleController.text.trim(),
//                                       detail: detailController.text.trim(),
//                                       price: int.parse(priceController.text.trim()),
//                                       token: auth.user!.token,
//                                       image: image
//                                   );
//
//                                 }
//
//
//                               }
//
//
//
//                             },
//                             child:crud.isLoad ? Center(child: CircularProgressIndicator(
//                               color: Colors.white,
//                             )): Text('Submit', style: TextStyle(fontSize: 20.sp),))
//                       ],
//                     ),
//                   ),
//                 ),
//
//
//               ],
//
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
// }
