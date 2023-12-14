import 'dart:io';

import 'package:blog_app/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class CreateBlog extends StatefulWidget {
  //const CreateBlog({ Key? key }) : super(key: key);

  @override
  //State<CreateBlog> createState() => _CreateBlogState();
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName = "", title = "", desc = "";

  // File selectedImage = File("file.txt");
  // File selectedImage= File('E/blog_app_temp1/assets/images/sunsetCapture.jpg');
  // var selectedImage= File('home.dart');
  File? selectedImage;

  final now = DateTime.now();

  // String formatter = DateFormat.yMd(now).add_jm();

  // Timestamp myTimeStamp = Timestamp.fromDate(now);
  // String dateFormatted = DateFormat('yyyy-MM-dd:jms').format(now);
  late String date = now.toString().substring(0,19);
  

  bool _isLoading = false;

  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    // var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // print(date);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      // setState(() {
      //   selectedImage = imageTemporary;
      // });
      setState(() => selectedImage = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // CollectionReference blogs = FirebaseFirestore.instance.collection('')

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc,
        "date": date,
      };

      // Map<String, dynamic> blogMap = {
      //   "imgUrl": downloadUrl,
      //   "authorName": authorName,
      //   "title": title,
      //   "desc": desc
      // };

      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}

    print("Working");
  }

  final urlImage='assets/images/sunsetCapture.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Gamer Zone",
              
              style: TextStyle(color: Colors.deepOrange, fontSize: 22, fontFamily: 'pixelEmulator'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Icon(Icons.file_upload, color: Colors.orange),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            // child: Image.file(selectedImage),
                            child: selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text("No image Selected"),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              // Icons.add_a_photo,
                              Icons.photo_library,
                              size: 50,
                              color: Colors.black54,
                            ),
                            // child: 
                            //   Image.asset(
                            //     urlImage,
                            //     fit: BoxFit.cover,

                            //   ),

                            
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Nickname"),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(hintText: "Description"),
                          onChanged: (val) {
                            desc = val;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
