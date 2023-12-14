// import 'dart:io';

import 'package:blog_app/views/create_blog.dart';
import 'package:blog_app/views/search.dart';
// import 'package:blog_app/views/show_blog.dart';
import 'package:blog_app/views/showing_blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../services/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

// QuerySnapshot blogsSnapshot;
  // Stream blogsStream = Stream.empty();
  Stream<QuerySnapshot> blogsStream =
      FirebaseFirestore.instance.collection('blogs').snapshots();

  Widget BlogsList() {
    return Container(
        child: blogsStream != null
            ? Column(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: blogsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print("something went wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final List storedocs = [];
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        storedocs.add(a);
                      }).toList();

                      return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                             child: Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                            Text('HEY GAMER,',style: TextStyle(fontSize: 24,fontFamily: 'pixelEmulator'),),
                            Text('What do you wanna gain today?',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'pixelEmulator'),),
                            ],)
                            ),
                            SizedBox(
                          height: 575,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemCount: storedocs.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogsTile(
                                authorName: storedocs[index]['authorName'],
                                title: storedocs[index]["title"],
                                description: storedocs[index]['desc'],
                                imgUrl: storedocs[index]['imgUrl'],
                                date: storedocs[index]['date'],
                              );
                              // SizedBox(height: 200);
                            },
                          ),
                        ),
                          ],
                        ));
                    },
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   crudMethods.getData().then((result) {
  //     setState(() {
  //       blogsStream = result;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Gamer Zone",
              style: TextStyle(fontSize: 22, color: Colors.deepOrange, fontWeight: FontWeight.bold, fontFamily: 'pixelEmulator'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // actions: <Widget>[
        //   GestureDetector(
        //     // onTap: () {
        //     //   Navigator.push(context,
        //     //       MaterialPageRoute(builder: (context) => MySearchDelegate()));
        //     // },
        //     onTap: (){
        //       showSearch(context: context, delegate: MySearchDelegate());

        //     },
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 25),
        //       child: Icon(Icons.search, color: Colors.blueAccent),
        //     ),
        //   ),
        // ],
      ),
      body: BlogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  // ShowingMethodsState showingMethodsState = new ShowingMethodsState();

// String imgUrl, title, description, authorName;
  late String imgUrl, title, description, authorName, date;
  // BlogsTile({@required this.imgUrl, @required this.title, @required this.description, @required this.authorName});
  BlogsTile(
      {required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName,
      required this.date});

  // String ddate= jiffy(date).formNow();
  // DateTime dt = DateTime.parse(date);

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  thatDate(){

    // return jiffy(date).formNow();
    print("hello");

  }

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showingMethodsState.Displaay();
        // Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => CreateBlog()));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowBloog(
                    imgUrl: imgUrl,
                    title: title,
                    description: description,
                    authorName: authorName,
                    date: date)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
            Container(
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.black45.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500,decoration: TextDecoration.underline,fontFamily: 'Times New Roman'),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400,fontFamily: 'Times New Roman'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'by: ' + authorName,
                      overflow: TextOverflow.ellipsis,
                      // style:
                        // TextStyle(fontFamily: 'Times New Roman'),
                    ),
                    SizedBox(height: 4),
                    Text(
                      timeAgo(DateTime.parse(date)),
                      // date,
                      overflow: TextOverflow.ellipsis,
                      // style:
                        // TextStyle(fontFamily: 'Times New Roman'),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
   