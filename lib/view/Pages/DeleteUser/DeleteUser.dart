import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view/Pages/ReadData/ShowData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';

class DeletePage extends StatefulWidget {
  DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final Controller c = Get.put(Controller());
  var _toDoController = TextEditingController();
  CollectionReference _todo = FirebaseFirestore.instance.collection('ToDo');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateUser(username) {
    return _todo
        .doc("${username!}")
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
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
                  updateUser(_toDoController.text);
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
