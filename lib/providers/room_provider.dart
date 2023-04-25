import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/common/firebae_instances.dart';



final roomStream =StreamProvider.autoDispose((ref) => FirebaseInstances.firebaseChat.rooms());
final roomProvider = Provider((ref) => RoomProvider());
final messageStream  = StreamProvider.family.autoDispose((ref, types.Room room) => FirebaseInstances.firebaseChat.messages(room));


class RoomProvider{

  Future<types.Room?> roomCreate(types.User user) async{
    try{
      final response = await FirebaseInstances.firebaseChat.createRoom(user);
      return response;
    }catch(err){
      return null;
    }
  }

}