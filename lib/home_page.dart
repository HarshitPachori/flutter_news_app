import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';
import 'package:news_app/news_detail.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // http request function

  Future<List> getData() async {
    var endPointUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey");

    var data = await http.get(endPointUrl);
    print(jsonDecode(data.body)['articles']);
    List<dynamic> news = jsonDecode(data.body)['articles'];
    return news;
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
                              if (snapshot.data![index]['urlToImage'] != null)
                                Image.network(
                                  snapshot.data![index]['urlToImage'],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              // if (snapshot.data![index]['author'] != null)
                              //   Text(
                              //     snapshot.data![index]['author'],
                              //     style: TextStyle(
                              //         color: Colors.grey,
                              //         fontSize: 15,
                              //         fontFamily:
                              //             GoogleFonts.fruktur().fontFamily
                              //         // fontFamily: GoogleFonts.irishGrover().fontFamily
                              //         ),
                              //   ),
                              //  Image.network(snapshot.data![index]['urlToImage']),
                              // Text(snapshot.data![index]['author']),
                              if (snapshot.data![index]['source']['name'] !=
                                  null)
                                Text(
                                  snapshot.data![index]['source']['name'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily:
                                          // GoogleFonts.fruktur().fontFamily
                                          GoogleFonts.irishGrover().fontFamily),
                                ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetail(
                                        title: snapshot.data![index]['title'] ??
                                            "",
                                        description: snapshot.data![index]
                                                ['description'] ??
                                            "",
                                        url: snapshot.data![index]['url'] ?? "",
                                        urlToImage: snapshot.data![index]
                                                ['urlToImage'] ??
                                            "https://pbs.twimg.com/media/Eg_pN2jWsAE-2se.jpg",
                                        publishedAt: snapshot.data![index]
                                                ['publishedAt'] ??
                                            "",
                                        source: snapshot.data![index]['source']
                                                ['name'] ??
                                            "",
                                        content: snapshot.data![index]
                                                ['content'] ??
                                            "",
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  snapshot.data![index]['title'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              //  Image.network(
                              //        snapshot.data![index]["publishedAt"]),

                              // Text(
                              //   snapshot.data![index]['description'].toString(),
                              //   style: TextStyle(
                              //     fontFamily: GoogleFonts.abel().fontFamily,
                              //     fontSize: 20,
                              //     color: Colors.blueGrey.shade900,
                              //   ),
                              // ),
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
      ),
    );
  }
}
