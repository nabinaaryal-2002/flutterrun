// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttersample1/common/firebae_instances.dart';
// import 'package:fluttersample1/services/auth_service.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/auth_state.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
//
//
// final authStream = StreamProvider.autoDispose((ref) => FirebaseInstances.firebaseAuth.authStateChanges());
// final usersStream = StreamProvider.autoDispose((ref) => FirebaseInstances.firebaseChat.users());
//
// final userStream = StreamProvider.family.autoDispose((ref, String userId) {
//   CollectionReference  users = FirebaseInstances.fireStore.collection('users');
//   return  users.doc(userId).snapshots().map((e) {
//     final data = e.data() as Map<String, dynamic>;
//     return types.User(
//         id: e.id,
//         imageUrl: data['imageUrl'],
//         firstName: data['firstName'],
//         metadata: {
//           'email': data['metadata']['email'],
//           'token':data['metadata']['token']
//         }
//     );
//   });
// });
//
// final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(AuthState.empty()));
//
// class AuthNotifier extends StateNotifier<AuthState> {
//   AuthNotifier(super.state);
//
//
//   Future<void> userSignUp({
//     required String username,
//     required String email,
//     required String password,
//     required XFile image
//   }) async {
//     state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
//     final response = await AuthService.userSignUp(username: username, email: email, password: password, image: image);
//     response.fold((l) {
//       state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
//     }, (r) {
//       state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
//     });
//   }
//
//
//
//
//   Future<void> userLogin({
//     required String email,
//     required String password
//   }) async {
//     state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
//     final response = await AuthService.userLogin(email: email, password: password);
//     response.fold((l) {
//       state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
//     }, (r) {
//       state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
//     });
//   }
//
//
//
//   Future<void> userLogOut() async {
//     state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
//     final response = await AuthService.userLogOut();
//     response.fold((l) {
//       state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
//     }, (r) {
//       state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
//     });
//   }
//
//
//
//
//
//
// }