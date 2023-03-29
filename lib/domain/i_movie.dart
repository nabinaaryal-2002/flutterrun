import 'package:dartz/dartz.dart';
import 'package:fluttersample1/domain/movie.dart';



abstract class MovieInterface{
Future<Either<String, List<Movie>>> getMovieCategory({required String apiPath});
}

