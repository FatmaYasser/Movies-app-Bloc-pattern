import 'package:flutter/material.dart';
import 'package:flutter_app/ui/movie-list.dart';

main() => runApp(MovieApp());

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[350],
        accentColor: Colors.cyan[600],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Watch Now'),
        ),
        body: MovieList(),
      ),
    );
  }
}
