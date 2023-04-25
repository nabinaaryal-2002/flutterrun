import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttersample1/common/firebae_instances.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/room_provider.dart';

class ChatPage extends ConsumerWidget {
  final types.Room room;
  final String token;
  final String username;
  ChatPage(this.room, this.token, this.username);

  @override
  Widget build(BuildContext context, ref) {
    final messageData = ref.watch(messageStream(room));
    return Scaffold(
        body: messageData.when(
            data:(data) =>  Chat(
              messages: data,
              showUserAvatars: true,
              showUserNames: true,
              onAttachmentPressed: ()async{
                final _pick = ImagePicker();
                await _pick.pickImage(source: ImageSource.gallery).then((value) async{
                  if(value !=null){
                    final imageId = DateTime.now().toString();
                    final ref = FirebaseInstances.firebaseStorage.ref().child('chatImage/$imageId');
                    await ref.putFile(File(value.path));
                    final url = await ref.getDownloadURL();
                    final size = File(value.path).lengthSync();
                    final message = types.PartialImage(
                        size: size,
                        name: value.name,
                        uri: url
                    );
                    FirebaseInstances.firebaseChat.sendMessage(message, room.id);

                  }
                });
              },
              onSendPressed: (PartialText val) async {
                final dio =Dio();
                try{
                  final response = await dio.post('https://fcm.googleapis.com/fcm/send',
                      data: {
                        "notification": {
                          "title": username,
                          "body": val.text,
                          "android_channel_id": "High_importance_channel"
                        },
                        "to": token

                      }, options: Options(
                          headers: {
                            HttpHeaders.authorizationHeader : 'key=AAAAX82UVWA:APA91bEMRhfWeK2767RACBxj77crr_H8r1IUiVJd0OcU4R8R6U0M-hCWjqwhKrugwoIZ3s5Lv4wHmWQDhhPyr-Vce1_d3N9HHwtQ7mG4tPJb5uT0myUSe45Q6X6ByhAMenlY0_Vb7iyb'
                          }
                      )
                  );
                  print(response.data);

                }on FirebaseException catch (err){
                  print(err);
                }

                FirebaseInstances.firebaseChat.sendMessage(val, room.id);
              }, user: types.User(
                id: FirebaseInstances.firebaseChat.firebaseUser!.uid
            ),

            ),
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}