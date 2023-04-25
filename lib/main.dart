
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/firebase_options.dart';
import 'package:fluttersample1/presentation/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';


final dio = Dio();

Future<void>  getData () async{
  try{
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    print(response.data);
  }on DioError catch(err){
    print(err.message);
    print(err.response);
  }


}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();


}


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "High_importance_channel",
  "High_importance_channel",
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const InitializationSettings initializationSettings =
InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
);




void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: appColor
      )
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  runApp(ProviderScope(child: Home()));
}



class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      builder: (context , child) {
        return GetMaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child:  StatusPage(),
    );
  }
}




class Counter extends StatelessWidget {

  StreamController<int> numberStream = StreamController();


  int number = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder<int>(
              stream: numberStream.stream,
              builder: (context, snapshot) {
                return Center(child: Text('${snapshot.data}', style: TextStyle(fontSize: 25),));
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          numberStream.sink.add(number++);
        },
        child: Text('add'),
      ),
    );
  }
}


