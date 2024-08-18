import 'dart:convert';

import 'package:api/Components/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Api 4',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: 'Name',
                                        value: data[index]['name'].toString()),
                                    ReusableRow(
                                        title: 'UserName',
                                        value:
                                            data[index]['username'].toString()),
                                    ReusableRow(
                                        title: 'Address',
                                        value: data[index]['address']['street']
                                            .toString())
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
