import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/Movie.dart';

List<movie> moviesList = [];

Future fetchMovie({required String URL, required String auth}) async {
  final response = await http.get(Uri.parse(URL), headers: {'Authorization': auth});

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['movies'];
  } else {
    throw Exception('Failed to connect to database.');
  }
}

Future retrieveMoviesList() async {

  var fetchedMovies =  await fetchMovie(
    URL: "https://wookie.codesubmit.io/movies",
    auth: "Bearer Wookie2021"
  );

  var movies = List<Map<String, dynamic>>.from(fetchedMovies);

  for(var _movie in movies){
    moviesList.add(
      movie(
          title: _movie["title"],
          released_on: _movie["released_on"],
          overview: _movie["overview"],
          imdb_rating: _movie["imdb_rating"],
          genres: _movie["genres"],
          poster: _movie["backdrop"],
          backdrop: _movie["poster"],
          length: _movie["length"],
          id: _movie["id"],
          isFavorite: false
      )
    );
  }

  return moviesList;
}