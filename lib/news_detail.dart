import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({
    Key? key,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String source;
  final String content;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.network(
                  widget.urlToImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 25),
                Text(
                  widget.title.trim(),
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Text(
                  widget.description.trim(),
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 25),
                Text(
                  "Published at : " + widget.publishedAt,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ));
  }
}
