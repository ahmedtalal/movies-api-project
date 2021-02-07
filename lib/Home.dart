import 'package:flutter/material.dart';
import 'package:testing/Models/Movies.dart';
import 'package:testing/NetworkingServices/HttpBuilder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Movies>> _movies;
  HttpBuilder _builder;
  bool checkColor = false ;
  @override
  void initState() {
    super.initState();
    _builder = HttpBuilder.getInstance();
    _movies =
        _builder.getMovies("https://api.androidhive.info/json/movies.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: FutureBuilder<List<Movies>>(
        future: _movies,
        builder: (BuildContext context, AsyncSnapshot<List<Movies>> snapshot) {
          if (snapshot.hasData) {
            List<Movies> movieList = snapshot.data;
            return ListView.builder(
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                Movies movieModel = movieList[index];
                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(movieModel.title),
                    leading: Image.network(
                      movieModel.image,
                    ),
                    subtitle: Column(
                      children: [
                        Text("Release on ${movieModel.releaseYear}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rating ${movieModel.rating}"),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: checkColor == true ?  Colors.red : Colors.grey ,
                                size: 20.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  checkColor = !checkColor ;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: movieModel.genre.map((item) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25.0,
                                    child: Center(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                    ),
                                  ),
                                ),
                              );
                            }).toList())
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print("error");
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
