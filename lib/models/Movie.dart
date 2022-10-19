
class movie {

  final String title, released_on, overview, length, id;
  final double imdb_rating;
  final List<dynamic> genres;
  final String? poster, backdrop;
  late bool isFavorite;

   movie({
    required this.title,
    required this.released_on,
    required this.overview,
    required this.imdb_rating,
    required this.genres,
    required this.poster,
    required this.backdrop,
    required this.length,
    required this.id,
    required this.isFavorite
  });

}