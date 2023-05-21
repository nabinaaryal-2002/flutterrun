
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/snackShow.dart';
import '../constants/colors.dart';
import '../providers/auth_provider.dart';
import 'package:get/get.dart';




class SignUpPage  extends  ConsumerWidget {

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
        Get.back();
      }
    });



    final auth = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.fireplace_rounded,color: Colors.black,),
            SizedBox(width: 10.w,),
            Text('Shop App',style: TextStyle(fontSize: 25.sp, color: Colors.black ),),
          ],
        ),
      ),

      body:  Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Form(
          key: _form,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('SignUp Page', style: TextStyle(fontSize: 25.sp,
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
                    width: 300.w,
                    child: Column(
                      children: [
                        Padding(
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
                                  hintStyle: TextStyle(color: Colors.white)
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
                                  hintStyle: TextStyle(color: Colors.white)
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
                                  hintStyle: TextStyle(color: Colors.white)
                              )
                          ),
                        ),



                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                foregroundColor: Colors.black
                            ),
                            onPressed: () {
                              _form.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if(_form.currentState!.validate()){


                                    ref.read(authProvider.notifier).userSignUp(
                                        username: usernameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),

                                    );




                              }


                            },
                            child: auth.isLoad ? Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )):
                            Text('SignUP', style: TextStyle(fontSize: 20.sp),)),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account'),
                            TextButton(onPressed: (){
                              // _form.currentState!.reset();
                              Get.back();
                            }, child: Text('Login'))
                          ],
                        )
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