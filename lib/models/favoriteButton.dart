import 'package:flutter/material.dart';
import '../services/accessDatabase.dart' as database;
import '../services/accessPreference.dart' as preference;

class favoriteButton extends StatefulWidget{

  final String currentMovieID;

  const favoriteButton({required this.currentMovieID});

  @override
  _favoriteButton createState() => _favoriteButton();
}

class _favoriteButton extends State<favoriteButton> {

  late String id;
  late int index = 0;

  bool added = false;

  @override
  void initState(){
    id = widget.currentMovieID;
    index = database.moviesList.indexWhere((element) =>
    element.id == id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Color.fromRGBO(48, 62, 86, 1),
                width: 1,
              ),
            )
        ),
        onPressed: () {
          if(database.moviesList[index].isFavorite) {
            setState(
                    (){
                  database.moviesList[index].isFavorite = false;
                  preference.deleteFavoriteMovie(database.moviesList[index].id);
                }
            );
          }
          else{
            setState(
                    (){
                  database.moviesList[index].isFavorite = true;
                  preference.saveFavoriteMovie(
                      database.moviesList[index].id,
                      database.moviesList[index].title
                  );
                }
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: 400,
          height: 50,
          alignment: Alignment.center,
          child: database.moviesList[index].isFavorite? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.done, color: Colors.deepPurple),
              Text(
                "Added to favorite!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ) : const Text(
            "Add to favorite",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(48, 62, 86, 1),
            ),
          ),
        )
    );
  }

}