import 'package:flutter/material.dart';
import 'package:movies_app/views/detailsPage.dart';
import 'package:movies_app/models/movieList_tile.dart';
import '../services/accessDatabase.dart' as database;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'favoritePage.dart';

class recommendPage extends StatefulWidget{
  const recommendPage({Key? key}) : super(key: key);

  @override
  _recommendPage createState() => _recommendPage();
}

class _recommendPage extends State<recommendPage>{
  var movieList = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    database.retrieveMoviesList().then((value) => movieList = value);
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
                  "Movies",
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
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                        Icons.slow_motion_video,
                        color: Colors.deepPurple ,
                        size: 30
                    ),
                    Text(
                        "Movies",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15
                    ))
                  ],
                  ),
                  onPressed: (){
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
            ),
            ElevatedButton(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                      Icons.favorite_outline_sharp,
                      color: Colors.blueGrey.shade300,
                      size: 25
                  ),
                  Text(
                      "Favorites",
                      style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 10
                      ))
                ],
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new favoritePage())
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
          ],
        ),
      ),
      body:FutureBuilder(
        future: database.retrieveMoviesList(),
        builder: (buildContext, AsyncSnapshot<dynamic> movies) {
          if (movies.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: movies.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        movieList = movies.data;
                        return Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showMaterialModalBottomSheet(
                                      bounce: true,
                                      elevation: 20,
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                            height: 720,
                                            child: detailsPage(
                                                movieDetails: movieList[index])
                                        );
                                      }
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.white),
                                ),
                                child: movieList_tile(
                                    title: movieList[index].title,
                                    backdrop: movieList[index].backdrop!,
                                    genres: movieList[index].genres
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
          }
          else{
            return Container();
          }
        }
      ),
    );

  }
}