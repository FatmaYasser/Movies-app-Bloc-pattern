import 'package:dio/dio.dart';
import 'dart:async' show Future;
import 'package:flutter_app/models/Movie-model.dart';
import 'package:flutter_app/models/trailer-model.dart';

class MovieNetwork {
  Response response;
  Dio dio = new Dio();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MovieModel> fetchMoviesList() async {
    response = await dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=31521ab741626851b73c684539c33b5a");
    print(response);
    if (response.statusCode == 200) {
      return MovieModel.fromJson(response.data);
    } else {
      throw Exception('failed to load data');
    }
  }

  Future<TrailerModel> fectchTrailer(int movieId) async {
    response = await dio.get('$_baseUrl/$movieId/videos?api_key=$_apiKey');
    print(response);
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(response.data);
    } else {
      throw Exception('failed to load trailers');
    }
  }
}
