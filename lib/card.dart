import 'package:flutter/material.dart';
import 'grid.dart';

class Hview extends StatefulWidget {
  @override
  _HviewState createState() => _HviewState();
}

class _HviewState extends State<Hview> {
  bool sbar = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _search = new TextEditingController();
  String name;
  void cha() {
    
    setState(() {
      _search.clear();
      sbar = sbar ? false : true;
    });
  }

  void _searchmovies(String text) {
    name = text;
    if (name.length >1) {
      print(name.length);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MovieGrid(data: name,)));
    } else {
      print("Weeoe");
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://placeimg.com/640/480/any/78"),
                  ),
                  accountName: new Text("Ankit Jain"),
                  accountEmail: null),
              new ListTile(
                leading: new Icon(Icons.movie_creation),
                title: Text("Watch List"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              new ListTile(
                leading: new Icon(Icons.favorite),
                title: Text("Favorite Movies"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              new ListTile(
                leading: new Icon(Icons.playlist_play),
                title: Text("TV sHOWS"),
                onTap: () => Navigator.pushNamed(context, '/grid'),
              ),
              Divider(),
              new ListTile(
                leading: new Icon(Icons.supervised_user_circle),
                title: Text("About us"),
              ),
              new ListTile(
                leading: new Icon(Icons.live_help),
                title: Text("Support"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: sbar
              ? TextField(
                  key: _formkey,
                  controller: _search,
                  onSubmitted: _searchmovies,
                  decoration: InputDecoration(
                      hintText: "Search Movies..",
                      hintStyle: TextStyle(color: Colors.white)),
                  
                )
              : Text("BoxOffice"),
          actions: <Widget>[
            sbar
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: cha,
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: cha,
                  ),
          ],
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Popular',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all    '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 250,
              child: new ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return new Card(
                    semanticContainer: true,
                    //  margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      width: 250,
                      child: Column(
                        children: <Widget>[
                          Image.network('https://placeimg.com/640/480/any/1',
                              fit: BoxFit.contain),
                          Row(
                            children: <Widget>[
                              Text("aws"),
                              Spacer(),
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
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Upcoming..',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all    '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              // width:100,
              height: 250,
              child: new ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return new Card(
                    semanticContainer: true,
                    //  margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 190,
                              child: Image.network(
                                  'https://placeimg.com/640/480/any/2',
                                  fit: BoxFit.fitHeight)),
                          Row(
                            children: <Widget>[
                              Text('Avengers'),
                              Spacer(),
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
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 12),
                new Text('Now Playing',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left),
                Spacer(),
                GestureDetector(
                  child: Text('View all    '),
                  onTap: () => Navigator.pushNamed(context, '/grid'),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 250,
              child: new ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return new Card(
                    semanticContainer: true,
                    //  margin: EdgeInsets.only(right: 10),
                    elevation: 2,
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      width: 250,
                      child: Column(
                        children: <Widget>[
                          Image.network('https://placeimg.com/640/480/any/3',
                              fit: BoxFit.contain),
                          Row(
                            children: <Widget>[
                              Text('Avengers: End Game'),
                              Spacer(),
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
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        )));
  }
}
