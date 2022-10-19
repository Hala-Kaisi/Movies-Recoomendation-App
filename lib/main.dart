import 'package:flutter/material.dart';
import 'package:movies_app/views/favoritePage.dart';
import 'package:movies_app/views/recommendPage.dart';
import 'services/accessDatabase.dart' as database;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/movies',
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/movies': (context) => const recommendPage(),
        '/favorites': (context) => favoritePage(),
      },
      home: const recommendPage(),
    );
  }
}

