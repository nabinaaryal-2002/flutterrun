import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttersample1/common/firebae_instances.dart';
import 'package:fluttersample1/common/snackShow.dart';
import 'package:fluttersample1/presentation/recent_chat.dart';
import 'package:fluttersample1/presentation/update_page.dart';
import 'package:fluttersample1/presentation/userDetail.dart';
import 'package:fluttersample1/providers/auth_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttersample1/providers/crud_provider.dart';
import 'package:fluttersample1/services/crud_service.dart';
import 'package:get/get.dart';

import 'package:fluttersample1/notification_service.dart';
import 'create_page.dart';
import 'detail_page.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late String userName;

  late types.User loginUser;

  final auth = FirebaseInstances.firebaseAuth.currentUser?.uid;

  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    // FirebaseMessaging.onMessage.listen(
    //       (message) {
    //     print("FirebaseMessaging.onMessage.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data11 ${message.data}");
    //       LocalNotificationService.createanddisplaynotification(message);
    //
    //     }
    //   },
    // );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // getToken();
  }



  // Future<void> getToken()async{
  //   final response = await FirebaseMessaging.instance.getToken();
  //   print(response);
  // }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final users = ref.watch(usersStream);
    final postData = ref.watch(postStream);
    final user = ref.watch(userStream(auth!));
    return Scaffold(
        appBar: AppBar(
          title: Text('Fire Chat'),
        ),
        drawer: Drawer(
            child: user.when(
                data: (data){
                  userName = data.firstName!;
                  loginUser = data;
                  return  ListView(
                    children: [
                      DrawerHeader(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(data.imageUrl!),
                              ),
                              SizedBox(width: 15,),
                              Text(data.firstName!),
                            ],
                          )
                      ),

                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        leading: Icon(Icons.email),
                        title: Text(data.metadata!['email']),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          Get.to(() => RecentChat(), transition: Transition.leftToRight);
                        },
                        leading: Icon(Icons.message),
                        title: Text('Recent Chats'),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          Get.to(() => CreatePage(), transition: Transition.leftToRight);
                        },
                        leading: Icon(Icons.add),
                        title: Text('Create Post'),
                      ),

                      ListTile(
                        onTap: (){
                          ref.read(authProvider.notifier).userLogOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Log Out'),
                      )
                    ],
                  );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(child: CircularProgressIndicator())
            )
        ),
        body: Column(
          children: [
            Container(
              height: 150.h,
              child: users.when(
                  data: (data){
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              Get.to(() => UserDetail(data[index]), transition: Transition.leftToRight);
                            },
                            child: Container(
                              width: 100.w,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: CachedNetworkImageProvider(data[index].imageUrl!),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(data[index].firstName!, style: TextStyle(fontSize: 17.sp),)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Container()
              ),
            ),

            Expanded(
                child: postData.when(
                    data: (data){
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index){
                            final post = data[index];
                            return  Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(post.title),
                                        if(auth == post.userId)  IconButton(onPressed: (){
                                          Get.defaultDialog(
                                              title: 'Customize Post',
                                              content: Text('Edit or remove post'),
                                              actions: [
                                                IconButton(
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                      Get.to(() => UpdatePage(post));
                                                    }, icon: Icon(Icons.edit)),
                                                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                                              ]
                                          );
                                        }, icon: Icon(Icons.more_horiz))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap:(){
                                        Get.to(() => DetailPage(post, loginUser), transition: Transition.leftToRight);
                                      },
                                      child: Image.network(post.imageUrl)),
                                  if(auth != post.userId)    Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              if(post.like.usernames.contains(userName)){
                                                SnackShow.showFailure(context, 'You have already like this post');
                                              }else{
                                                post.like.usernames.add(userName);
                                                ref.read(crudProvider.notifier).addLike(
                                                    username: post.like.usernames,
                                                    like: post.like.likes,
                                                    postId: post.id
                                                );
                                              }
                                            }, icon: Icon(Icons.thumb_up)),
                                        if(post.like.likes != 0)    Text('${post.like.likes}')

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator())
                )
            )

          ],
        )
    );
  }
}












