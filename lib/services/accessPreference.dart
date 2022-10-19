import 'package:shared_preferences/shared_preferences.dart';

void saveFavoriteMovie (String movieID, String movieTitle) async{
  var preference = await SharedPreferences.getInstance();
  preference.setString(movieID, movieTitle);
}

void deleteFavoriteMovie (String movieID) async {
  var preference = await SharedPreferences.getInstance();
  preference.remove(movieID);
}

Future<Set<String>> retrieveFavoriteMovies() async {
  var preference = await SharedPreferences.getInstance();
  Set<String> moviesID = {};
  if(preference.getKeys().isNotEmpty){
    moviesID = preference.getKeys();
  }
  return moviesID;
}