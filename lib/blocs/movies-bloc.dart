import 'package:flutter_app/models/Movie-model.dart';
import 'package:flutter_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MovieBloc {
  final _reopistory = Repository();
  final _movieFetcher = PublishSubject<MovieModel>();

  Observable<MovieModel> get allMovies => _movieFetcher.stream;

  fetchAllmovies() async {
    MovieModel movieModel = await _reopistory.fetchAllmovies();
    _movieFetcher.sink.add(movieModel);
  }

  dispose() {
    _movieFetcher.close();
  }
}

final bloc = MovieBloc();
