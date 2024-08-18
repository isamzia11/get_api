import 'dart:convert';

import 'package:api/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postlist = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      postlist.clear();
      var data = jsonDecode(response.body);
      for (Map i in data) {
        postlist.add(PostsModel.fromJson(i as Map<String, dynamic>));
      }
      return postlist;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'API',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  } else {
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Colors.cyan,
                            surfaceTintColor: Colors.amber,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Title ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(postlist[index].title.toString()),
                                  const Text(
                                    'id ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(postlist[index].id.toString())
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
