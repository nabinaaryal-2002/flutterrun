import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttersample1/domain/movie.dart';
import 'package:fluttersample1/domain/i_movie.dart';

class MovieService implements MovieInterface{
  final Dio dio;
  MovieService(this.dio);



  @override
  Future<Either<String, List<Movie>>> getMovieCategory({required String apiPath}) async {
    try{
      final response  =await dio.get(apiPath);
      final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return Right(data);
    }on DioError catch(err) {
      return Left(err.message);
    }

      }
      // Todo: implement getMovieCategory
      // throw UnimplementedError();
    }
