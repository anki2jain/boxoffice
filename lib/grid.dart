import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:last_app/detail.dart';

class MovieGrid extends StatefulWidget {
  const MovieGrid({Key key, this.data}) : super(key: key);
  // final FirebaseUser user;
  final String data;
  @override
  _MovieGridState createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  var search="Avenger";
  var imp;
  bool isloading = true;
  Future<String> getdata(data) async {
    print(data);
    http.Response response = await http.get(
        Uri.encodeFull(
          "https://api.themoviedb.org/3/search/multi?api_key=2931998c3a80d7806199320f76d65298&query=$data&page=1&include_adult=false"),
            // "https://api.themoviedb.org/3/search/movie?api_key=2931998c3a80d7806199320f76d65298&query=$data"),
        headers: {
          "key": "",
        });

    this.setState(() {
      imp = json.decode(response.body);
      isloading = false;
    });

    print(imp["total_results"]);
    print(imp["results"][1]["title"]);
    print(imp["results"][10]["poster_path"]);
  }

  @override
  void initState() {
    search = "${widget.data}";
    print(search);
    this.getdata(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: isloading
          ? Center(
              child:SpinKitFadingCircle(
                      color: Colors.blueAccent,
                      size: 50.0,
                    ),
            )
          : GridView.builder(
              itemCount: imp == 0
                  ?imp["results"].length == null
                  : imp["results"].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.5,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                   onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  data: imp["results"][index ]["id"],
                                ))),
                                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 138,
                          child: Builder(builder: (BuildContext context) {
                            try {
                              return Image.network(
                                'https://image.tmdb.org/t/p/w500/' +
                                    imp["results"][index]["poster_path"],
                                fit: BoxFit.fitHeight,
                              );
                            } catch (e) {
                              return Image.network(
                                'http://sfwallpaper.com/images/image-not-available-11.jpg',
                                fit: BoxFit.fitHeight,
                              ) ;
                            }
                          }),
                        ),
                        
                        Row(
                          children: <Widget>[
                            imp["results"][index]["title"]!=null?Flexible(
                                child:Text(imp["results"][index]["title"],
                                    overflow: TextOverflow.clip)):Flexible(
                                child:Text(imp["results"][index]["name"],
                                    overflow: TextOverflow.clip)),
                            // Spacer(),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
