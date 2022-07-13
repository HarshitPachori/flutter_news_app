import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

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

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // http request function

  Future<List> getData() async {
    var endPointUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=e91ac0340271432586b12c7fcc5e7f4a");

    var data = await http.get(endPointUrl);
    print(jsonDecode(data.body)['articles']);
    return jsonDecode(data.body)['articles'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter",
                style: TextStyle(
                    color: Colors.black87,
                    //     fontWeight: FontWeight.w600,
                    fontSize: 30,
                    fontFamily: GoogleFonts.fruktur().fontFamily
                    // fontFamily: GoogleFonts.irishGrover().fontFamily
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "News ",
                style: TextStyle(
                    color: Colors.blue,
                    // fontWeight: FontWeight.w600,
                    fontSize: 30,
                    fontFamily: GoogleFonts.irishGrover().fontFamily
                    // fontFamily: GoogleFonts.fruktur().fontFamily,
                    ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                //  Image.network(snapshot.data![index]['urlToImage']),
                                // Text(snapshot.data![index]['author']),
                                Text(
                                  snapshot.data![index]['title'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                      fontWeight: FontWeight.w400),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //  Image.network(
                                //        snapshot.data![index]["publishedAt"]),

                                Text(
                                    snapshot.data![index]['description']
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: GoogleFonts.abel().fontFamily,
                                      fontSize: 20,
                                      color: Colors.blueGrey.shade900,
                                    )),
                                //       .toString()),
                                // Text(snapshot.data![index]['content']),
                              ],
                            ),
                          );
                        });
                  }
                } on Exception catch (e) {
                  print(e);
                }
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              }),
        ));
  }
}
