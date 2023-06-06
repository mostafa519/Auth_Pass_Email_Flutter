import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view/Pages/ReadData/ShowData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller c = Get.put(Controller());
  var _toDoController = TextEditingController();
  CollectionReference _todo = FirebaseFirestore.instance.collection('ToDo');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addTodo(String toDoTitle) {
    return _todo
        .add({
          'userId': auth.currentUser!.uid ?? "no user",
          'toDoTitle': toDoTitle,

          // 'full_name': fullName, // John Doe
          // 'company': company, // Stokes and Sons
          // 'age': age // 42
        })
        .then((value) => print("To Do Added"))
        .catchError((error) => print("Failed to add To Do: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "To Do Title",
              ),
              controller: _toDoController,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  addTodo(_toDoController.text);
                },
                child: Icon(Icons.add)),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(ShowData());
                },
                child: Text("Todo"))
          ],
        ),
      ),
    );
  }
}
