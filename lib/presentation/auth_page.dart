import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/snackShow.dart';
import '../constants/colors.dart';
import '../providers/auth_provider.dart';
import '../providers/toggle_provider.dart';



class AuthPage extends  ConsumerWidget {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {

    ref.listen(authProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'succesfully login');
      }
    });

    final isLogin = ref.watch(loginProvider);
    final image = ref.watch(imageProvider);
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
        padding: const EdgeInsets.only(top: 120),
        child: Form(
          key: _form,
          child: Column(
            children: [
              Text(isLogin ? 'Login Page' : 'SignUp Page', style: TextStyle(fontSize: 25.sp,
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
                      if(!isLogin)   Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 8),
                        child: TextFormField(
                            controller: usernameController,
                            validator: (val){
                              if(val!.isEmpty){
                                return 'username is required';
                              }else if(val.length > 20){
                                return 'minimum character exceed';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),

                                // fillColor: Colors.black,
                                filled: true,
                                hintText: 'Enter an username',
                                hintStyle: TextStyle(color: Colors.grey)
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 8),
                        child: TextFormField(
                            controller: emailController,
                            validator: (val){
                              if(val!.isEmpty){
                                return 'email is required';
                              }else if(!val.contains('@')){
                                return 'please enter valid email';
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
                                hintText: 'E-MAIL',
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
                                return 'password is required';
                              }else if(val.length > 30){
                                return 'minimum character exceed';
                              }
                              return null;
                            },
                            obscureText: true,
                            controller: passwordController,
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
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey)
                            )
                        ),
                      ),

                      if(!isLogin)   InkWell(
                        onTap: (){
                          ref.read(imageProvider.notifier).pickAnImage();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: 100.h,
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

                              if(isLogin){
                                ref.read(authProvider.notifier).userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()
                                );
                              }else{
                                if(image == null){
                                  SnackShow.showFailure(context, 'please select an image');
                                }else{
                                  ref.read(authProvider.notifier).userSignUp(
                                      username: usernameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      image: image
                                  );
                                }


                              }
                            }


                          },
                          child:auth.isLoad ? Center(child: CircularProgressIndicator(
                            color: Colors.white,
                          )): Text(
                            isLogin ? 'Login' : 'SignUP', style: TextStyle(fontSize: 20.sp),))
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLogin ?'Don\'t have an account ?,' : 'Already have an account',
                    style: TextStyle(color: Colors.grey),),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: primary
                      ),
                      onPressed: () {
                        _form.currentState!.reset();
                        ref.read(loginProvider.notifier).change();
                      },
                      child: Text(isLogin ?  'Create One' : 'Login',))
                ],
              )

            ],

          ),
        ),
      ),
    );

  }
}