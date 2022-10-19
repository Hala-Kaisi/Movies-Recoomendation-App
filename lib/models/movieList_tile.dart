import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class movieList_tile extends StatefulWidget{
  final String title, backdrop;
  final List<dynamic> genres;

  const movieList_tile({
    required this.title,
    required this.backdrop,
    required this.genres
  });

  @override
  _movieList_tile createState() => _movieList_tile();
}

class _movieList_tile extends State<movieList_tile> {

  late String _title, _backdrop;
  late List<dynamic> _genres;

  @override
  void initState(){
    _title = widget.title;
    _backdrop = widget.backdrop;
    _genres = widget.genres;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String genresDisplay = "";
    for(int i=0; i<_genres.length; i++){
      genresDisplay = genresDisplay + _genres[i] + " | ";
    }
    genresDisplay = genresDisplay.substring(0, genresDisplay.length-2);
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.only(left: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: _backdrop,
                  ),
                ),
              ),
            Expanded(
              child: ListTile(
                horizontalTitleGap: 10,
                tileColor: Colors.white,
                hoverColor: Colors.deepPurple[50],
                trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                    color: Colors.blueGrey.shade400
                ),
                title:Text(
                      genresDisplay,
                      style: TextStyle(
                          color: Colors.blueGrey.shade400,
                          wordSpacing: 0.001,
                          fontWeight: FontWeight.w600,
                          fontSize: 12
                      )
                  ),
                  subtitle:Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                        _title,
                        style: const TextStyle(
                          color: Colors.black,
                          wordSpacing: 0.001,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                        )
                      ),
                  ),
                ),
            ),
          ],
      ),
    );
  }
  
}