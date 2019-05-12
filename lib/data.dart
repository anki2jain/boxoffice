import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Future<Post> fetchPost() async {
//   final response =
//       await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }

// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;

//   Post({this.userId, this.id, this.title, this.body});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
class JsonTest extends StatefulWidget {
  @override
  _JsonTestState createState() => _JsonTestState();
}

class _JsonTestState extends State<JsonTest> {
  var imp;
   Future<String> getdata() async {
http.Response response  = await http.get(
  Uri.encodeFull("https://api.themoviedb.org/3/search/movie?api_key=2931998c3a80d7806199320f76d65298&query=mission+impossible"),
  headers: {
    "key": "",
     }
);

// url= "https://api.themoviedb.org/3/movie/550?api_key=2527aff3fe66c4f63dddf2241c0776cd"
// print(response.body);
// List data = JSONDecode(response.body);
imp = json.decode(response.body);
print(imp["total_results"]);
print(imp["results"][0]["title"]);
// var abc=data["spoken_languages"];
// List newd =json.decode(abc);
// print(newd[1]["name"]);
// show(data);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child:Column(
            children: <Widget>[
              // Text(abc);
              IconButton(
                icon: Icon(Icons.get_app),
                onPressed: getdata,
              ),
            ],
          ),
        ),
    );
  }
}
