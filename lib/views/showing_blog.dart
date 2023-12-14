import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class ShowBloog extends StatelessWidget {
  late String imgUrl, title, description, authorName,date;
  ShowBloog(
      {required this.imgUrl,
      required this.title,
      required this.description,
      required this.authorName,
      required this.date});
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding:EdgeInsets.fromLTRB(00, 0, 20, 0),
            // ),
            Text(
              
              "Gamer Zone",
              style: TextStyle(fontSize: 22, color: Colors.deepOrange, fontFamily: 'pixelEmulator'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        // padding: EdgeInsets.only(bottom:50),
        // height: 800,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  // child: Image.file(selectedImage),
        
                  child: ClipRRect(
                      // borderRadius: BorderRadius.circular(6),
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ))),
              SizedBox(
                height: 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        // 'Title',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 35, fontWeight: FontWeight.w500,decoration: TextDecoration.underline,),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 30),
                      Text(
                        '- ' + authorName,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '   ' + date.substring(0,10),
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        // overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 200),
                    ]
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
