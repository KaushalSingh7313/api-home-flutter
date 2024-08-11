// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class api_home extends StatefulWidget {
//   const api_home({super.key});
//
//   @override
//   State<api_home> createState() => _api_homeState();
// }
//
// class _api_homeState extends State<api_home> {
//   List<SamplePosts> samplePosts = [];
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if(snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: samplePosts.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     height: 110,
//                     color: Colors.greenAccent,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                     margin: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'User id : ${samplePosts[index].userId}',
//                           style: TextStyle(fontSize: 18),
//                         ),
//
//                         Text(
//                           ' id :${samplePosts[index].Id} ',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'tital id :${samplePosts[index].title} ',
//                           maxLines: 1,
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           'body id :${samplePosts[index].body} ',
//                           maxLines: 1,
//                           style: TextStyle(fontSize: 18),
//                         )
//                       ],
//                     ),
//                   );
//                 });
//           }
//           else{
//             return Center(child: CircularProgressIndicator(),);
//           }
//         }
//     );
//   }
//
//   Future<List<kaushalapiFromJson>>getData() async{
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     var data =  jsonDecode(response.body.toString());
//
//     if(response.statusCode == 200) {
//       for (Map<String, dynamic> index in data) {
//         samplePosts.add(SamplePosts.fromjson(index));
//       }
//       return samplePosts;
//     } else{
//       return samplePosts;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Define the data model class
class Kaushalapi {
  int userId;
  int id;
  String title;
  String body;

  Kaushalapi({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Kaushalapi.fromJson(Map<String, dynamic> json) {
    return Kaushalapi(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class ApiHome extends StatefulWidget {
  const ApiHome({super.key});

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  List<Kaushalapi> samplePosts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Home'),
      ),
      body: FutureBuilder<List<Kaushalapi>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            samplePosts = snapshot.data!;
            return ListView.builder(
              itemCount: samplePosts.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  color: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User id: ${samplePosts[index].userId}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'ID: ${samplePosts[index].id}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Title: ${samplePosts[index].title}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Body: ${samplePosts[index].body}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Future<List<Kaushalapi>> getData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Kaushalapi> posts = data.map((item) => Kaushalapi.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load data');
    }
  }
}