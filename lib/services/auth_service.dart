import 'dart:io';
import 'package:fluttersample1/api.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';






class AuthService {


static final dio = Dio();


  static  Future<Either<String, bool>> userSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try{
      final response  = await dio.post(Api.userSignUp, data: {
        'email':email,
        'full_name': username,
        'password':password
      });
      return Right(true);
    }on DioError catch(err){
      return Left(err.message);
    }
  }




  static  Future<Either<String, bool>> userLogin({
    required String email,
    required String password
  }) async {
    try{
      final response  = await dio.post(Api.userLogin, data: {
        'email':email,
        'password':password
      });


      return Right(true);
    }on DioError catch(err){
      return Left(err.response?.data['message']);
    }
  }







}