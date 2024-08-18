import 'dart:convert';

import 'package:api/Components/reusable_row.dart';
import 'package:api/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      userList.clear();
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }

      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Api 3',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: Colors.lime,
                              surfaceTintColor: Colors.limeAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: 'Name',
                                        value: snapshot.data![index].name
                                            .toString()),
                                    ReusableRow(
                                        title: 'Address',
                                        value: snapshot.data![index].address
                                            .toString()),
                                    ReusableRow(
                                        title: 'Email',
                                        value: snapshot.data![index].email
                                            .toString()),
                                    ReusableRow(
                                        title: 'Adress',
                                        value: snapshot
                                                .data![index].address!.city
                                                .toString() +
                                            snapshot
                                                .data![index].address!.geo!.lat
                                                .toString()),
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
