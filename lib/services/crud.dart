import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

  Future<void> addData(blogData) async{

    FirebaseFirestore.instance.collection("blogs").add(blogData).catchError((e){

      print(e);

    });

    // FirebaseFirestore.instance.collection("blogs").add(blogData).catchError((error) => print('Failed to  Add user:$error'));

  }

  getData() async{

    return await FirebaseFirestore.instance.collection("blogs").snapshots();

  }

}