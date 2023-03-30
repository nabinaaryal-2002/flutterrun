import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../api.dart';
import '../exception/api_exception.dart';
import '../models/movie.dart';
import '../models/video.dart';



class MovieService {

  static final dio = Dio();

  static  Future<Either<String, List<Movie>>> getMovieCategory(
      {required String apiPath, required int page}) async {
    try{
      final response  = await dio.get(apiPath, queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8',
        'page': page
      });
      final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return Right(data);
    }on DioError catch(err){
      return Left(DioException.getDioError(err));
    }
  }


  static  Future<Either<String, List<Movie>>> getSearchMovie({required String searchText}) async {
    try{
      final response  = await dio.get(Api.searchMovie, queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8',
        'query': searchText
      });

      if((response.data['results'] as List).isEmpty){
        return Left('Try using another keyword');
      }else{
        final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
        return Right(data);
      }


    }on DioError catch(err){
      return Left(DioException.getDioError(err));
    }
  }


  static  Future<Either<String, List<Video>>> getMovieId({required int movieId}) async {
    try{
      final response  = await dio.get('${Api.getVideoId}/$movieId/videos', queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8',
      });

      if((response.data['results'] as List).isEmpty){
        return Left('No Videos were found');
      }else{
        final data = (response.data['results'] as List).map((e) => Video.fromJson(e)).toList();
        return Right(data);
      }
    }on DioError catch(err){
      return Left(DioException.getDioError(err));
    }
  }




}