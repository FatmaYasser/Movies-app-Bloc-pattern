import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/movie-detail-bloc-provider.dart';
import 'package:flutter_app/models/Movie-model.dart';
import 'package:flutter_app/blocs/movies-bloc.dart';
import 'package:flutter_app/ui/movie-detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllmovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  List isFav = List();
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<MovieModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MovieModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: GestureDetector(
              child: new GridTile(
                header: Padding(
                  padding: const EdgeInsets.only(left: 110, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!isFav.contains(snapshot.data.results[index].id)) {
                          isFav.add(snapshot.data.results[index].id);
                        }
                        isfav = !isfav;
                      });
                    },
                    child: isFav.contains(snapshot.data.results[index].id)
                        ? Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                  ),
                ),
                footer: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      snapshot.data.results[index].title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
                child: new Image.network(
                  "https://image.tmdb.org/t/p/w200" +
                      snapshot.data.results[index].posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MovieDetailBlocProvider(
                      child: MovieDetail(
                        title: snapshot.data.results[index].title,
                        posterUrl: snapshot.data.results[index].backdropPath,
                        description: snapshot.data.results[index].overview,
                        releaseDate: snapshot.data.results[index].releaseDate,
                        voteAverage:
                            snapshot.data.results[index].voteAverage.toString(),
                        movieId: snapshot.data.results[index].id,
                      ),
                    );
                  }),
                );
              },
            ),
          );
        });
  }
}
