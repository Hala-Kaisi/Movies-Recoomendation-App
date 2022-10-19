import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/favoriteButton.dart' as button;
import '../models/Movie.dart';
import '../models/favoriteButton.dart';

class detailsPage extends StatefulWidget{

  final movie movieDetails;

  const detailsPage({
    required this.movieDetails
  });

  @override
  _detailsPage createState() => _detailsPage();
}

class _detailsPage extends State<detailsPage>{

  late movie _movieDetails;

  @override
  void initState(){
    _movieDetails = widget.movieDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 45),
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent)
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey.shade400,
                  size: 30,
                ),
              ),
            ],
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(55),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 40),
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  _movieDetails.title,
                  style: const TextStyle(
                      color: Color.fromRGBO(48, 62, 86, 1),
                      fontSize:25,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(right: 25),
                    child: Text(
                      _movieDetails.imdb_rating.toString() + " stars",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(48, 62, 86, 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 350,
                        height: 320,
                        imageUrl: _movieDetails.poster!,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25, top: 360),
                    child: Text(
                      _movieDetails.length,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(48, 62, 86, 1),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(right: 25, top: 360),
                    child: Text(
                      _movieDetails.released_on.substring(0,_movieDetails.released_on.length-9 ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(48, 62, 86, 1),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 25, left: 25, top: 400),
                    child: Text(
                      _movieDetails.overview,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(48, 62, 86, 1),
                        fontWeight: FontWeight.w400,
                        //letterSpacing: 0.75,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ]
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                margin: const EdgeInsets.only(right: 25, left: 25),
                alignment: Alignment.bottomCenter,
                child: favoriteButton(currentMovieID: _movieDetails.id),
              )
            ],
          ),
        ),
      ),
    );
  }



}