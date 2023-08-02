import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import '../model/movies.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  String movieTitle = '';
  String movieOverview = '';
  String poster_path = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String title = widget.title; // Access title from the widget's properties

    var url =
        'https://api.themoviedb.org/3/movie/$title?api_key=a476d5d2090061c3a880af4d582751be';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Assuming the response data follows the Movie class structure
        final movie = Movie.fromJson(data);
        setState(() {
          movieTitle = movie.original_title;
          movieOverview = movie.overview;
          poster_path = movie.poster_path;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 5, 30),
                  child: Text(
                    movieTitle.isNotEmpty ? movieTitle : "",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 7, 7),
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: poster_path.isNotEmpty
                    ? Image.network(
                        "https://image.tmdb.org/t/p/w500/${poster_path}",
                        fit: BoxFit.contain,
                      )
                    : Text(""),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: Text(
                  movieOverview.isNotEmpty ? movieOverview : "",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 39, 37, 37),
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
