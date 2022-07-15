
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:news_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
      home: const Homepage(),
     
    );
  }
}
