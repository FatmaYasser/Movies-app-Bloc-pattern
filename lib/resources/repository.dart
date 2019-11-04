import 'package:flutter_app/models/Movie-model.dart';
import 'package:flutter_app/models/trailer-model.dart';
import 'package:flutter_app/resources/movie-network.dart';

class Repository {
  final movieNetwork = MovieNetwork();
  Future<MovieModel> fetchAllmovies() => movieNetwork.fetchMoviesList();
  Future<TrailerModel> fetchTrailers(int movieId) =>
      movieNetwork.fectchTrailer(movieId);
}
