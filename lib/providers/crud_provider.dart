import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttersample1/models/crud_state.dart';
import 'package:fluttersample1/services/crud_service.dart';




final crudProvider = StateNotifierProvider<CrudNotifier, CrudState>((ref) => CrudNotifier(CrudState.empty()));

class CrudNotifier extends StateNotifier<CrudState> {
  CrudNotifier(super.state);


  Future<void>  addPost({
    required String title,
    required String detail,
    required int  price,
    required String token,
    required XFile image
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await CrudService.addProduct(title: title, detail: detail, token: token, price: price, image: image);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


//
//
// Future<void>  deletePost({
//   required String postId,
//   required String imageId,
// }) async {
//   state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
//   final response = await CrudService.deletePost(postId: postId, imageId: imageId);
//   response.fold((l) {
//     state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
//   }, (r) {
//     state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
//   });
// }
//
//
//
//   Future<void> updatePost({
//   required String title,
//   required String detail,
//   required String postId,
//     XFile? image,
//    String? imageId
// }) async {
//   state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
//   final response = await CrudService.updatePost(title: title, detail: detail, postId: postId, image: image, imageId: imageId);
//   response.fold((l) {
//     state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
//   }, (r) {
//     state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
//   });
// }




}