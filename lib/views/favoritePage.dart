import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'detailsPage.dart';
import '../services/accessDatabase.dart' as database;
import '../models/movieList_tile.dart';
import '../services/accessPreference.dart' as preference;

class favoritePage extends StatefulWidget{

  @override
  _favoritePage createState() => _favoritePage();
}

class _favoritePage extends State<favoritePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: const Text(
                "Favorites",
                style: TextStyle(
                    color: Color.fromRGBO(48, 62, 86, 1),
                    fontSize:35,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: preference.retrieveFavoriteMovies(),
        builder: (buildContext, AsyncSnapshot<Set<String>> favorites){
          if(!favorites.hasData){
            return Center(
                child: Text(
                  "Your favorites list is empty",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 20
                  ),
                )
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child:ListView.builder(
                    shrinkWrap: true,
                    itemCount: favorites.data?.length,
                    itemBuilder: (BuildContext ctxt, int index){
                      return Column(
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                showMaterialModalBottomSheet(
                                  bounce: true,
                                  elevation: 20,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                        height: 720,
                                        child: detailsPage(movieDetails: database
                                            .moviesList.firstWhere(
                                                (element) =>
                                            element.id == favorites.data?.elementAt(index))
                                        )
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              child: movieList_tile(
                                  title: database.moviesList.firstWhere(
                                          (element) => element.id == favorites.data?.elementAt(index)).title,
                                  backdrop: database.moviesList.firstWhere(
                                          (element) => element.id == favorites.data?.elementAt(index)).backdrop!,
                                  genres: database.moviesList.firstWhere(
                                          (element) => element.id == favorites.data?.elementAt(index)).genres
                              )
                          ),
                          Divider(
                            indent: 110,
                            height: 0,
                            thickness: 0.5,
                            color: Colors.blueGrey.shade100,
                          ),
                        ],
                      );
                    }
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(
                      Icons.slow_motion_video,
                      color: Colors.blueGrey.shade300 ,
                      size: 25
                  ),
                  Text(
                      "Movies",
                      style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 10
                      ))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: Column(
                children: const [
                  Icon(
                      Icons.favorite_outline_sharp,
                      color: Colors.deepPurple,
                      size: 30
                  ),
                  Text(
                      "Favorites",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}