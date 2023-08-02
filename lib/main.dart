import 'package:flutter/material.dart';
import 'components/home-page.dart';
import 'components/movie-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gorkem',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 57, 62, 70),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromARGB(0, 255, 66, 66),
        ),
      ),
      home: HomePage(title: 'Home Page'),
      routes: {
        // Define the route for the second page
        '/second': (context) => MoviePage(
              title: "The Endless Summer",
            ),
      },
    );
  }
}
