import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluttersample1/api.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloudinary_public/cloudinary_public.dart';

class CrudService {
  static final dio = Dio();

  static  Future<Either<String, bool>> addProduct({
    required String title,
    required String detail,
    required String token,
    required int price,
    required XFile image
  }) async {
    try{
      try {
        final cloudinary = CloudinaryPublic('diiv6ljqv', 'shopapp', cache: false);
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
        );
        await dio.post(Api.addProduct, data: {
          'product_name': title,
          'product_detail': detail,
          'price': price,
          'imageUrl': response.secureUrl,
          'public_id': response.publicId
        }, options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token'
            }
        )
        );
      } on CloudinaryException catch (e) {
        print(e.message);

      }
      return Right(true);
    }on DioError catch(err){
      return Left(err.message);
    }
  }
  // static  Future<Either<String, bool>> updatePost({
  //   required String title,
  //   required String detail,
  //   required String postId,
  //   required XFile? image,
  //   required String? imageId
  // }) async {
  //   try{
  //     if(image == null){
  //       await  postDb.doc(postId).update({
  //         'title': title,
  //         'detail': detail
  //       });
  //     }else{
  //       final ref = FirebaseInstances.firebaseStorage.ref().child('postImage/$imageId');
  //       await ref.delete();
  //       final newImageId = DateTime.now().toString();
  //       final ref1 = FirebaseInstances.firebaseStorage.ref().child('postImage/$newImageId');
  //       await ref1.putFile(File(image.path));
  //       final url = await ref1.getDownloadURL();
  //
  //       await  postDb.doc(postId).update({
  //         'title': title,
  //         'detail': detail,
  //         'imageUrl': url,
  //         'imageId': newImageId,
  //       });
  //
  //     }
  //
  //     return Right(true);
  //   }on FirebaseException catch(err){
  //     return Left(err.message!);
  //   }
  // }
  //
  //
  //
  //
  //
  // static  Future<Either<String, bool>> deletePost({
  //   required String postId,
  //   required String imageId,
  // }) async {
  //   try{
  //
  //     final ref = FirebaseInstances.firebaseStorage.ref().child('postImage/$imageId');
  //     await ref.delete();
  //
  //     await postDb.doc(postId).delete();
  //     return Right(true);
  //   }on FirebaseException catch(err){
  //     return Left(err.message!);
  //   }
  // }
  //
  //
  //
  //
  //
  //



}