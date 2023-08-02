import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/movielist.dart';
import 'movie-page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> results = {};
  @override
  void initState() {
    fetchData();

    super.initState();
  }

  void fetchData() async {
    const url =
        'https://api.themoviedb.org/4/list/8262855?api_key=a476d5d2090061c3a880af4d582751be&sort_by=created_at.desc';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final movielist = MovieList.fromJson(data);
        setState(() {
          final movielist = MovieList.fromJson(data);
          results = {
            'results': movielist.results,
            'page': movielist.page,
          };
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
          child: ListView.builder(
            itemCount: results['results']?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = results['results']?[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoviePage(title: "${movie?["id"].toString()}")),
                    );
                  },
                  child: ListTile(
                    title: Text(movie?['title'] ?? ''),
                    subtitle: Text(movie?['overview'] ?? ''),
                    trailing:
                        Text("Rating: ${movie?['vote_average'] ?? 'N/A'}"),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
