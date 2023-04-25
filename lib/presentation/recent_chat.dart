import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/common/firebae_instances.dart';
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';


class RecentChat extends ConsumerWidget {

  final uid = FirebaseInstances.firebaseAuth.currentUser!.uid;
  @override
  Widget build(BuildContext context, ref) {
    final rooms = ref.watch(roomStream);
    return Scaffold(
        body: rooms.when(
            data: (data){
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    final otherUser = data[index].users.firstWhere((element) => element.id != uid);
                    return ListTile(
                      onTap: (){
                        Get.to(() => ChatPage(data[index], otherUser.metadata!['token'], otherUser.firstName!));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].imageUrl!),
                      ),
                      title: Text(data[index].name!),
                    );
                  }
              );
            },
            error: (err, stack) => Text('$err'),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}