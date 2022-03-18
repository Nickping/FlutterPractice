
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/nasa/network/NasaApi.dart';
import 'package:http/http.dart' as http;
import 'package:second_project/post/network/PostApi.dart';
import 'package:second_project/main.dart';
import 'package:second_project/nasa/view/planet_screen.dart';
import '../../post/model/Post.dart';



class SimpleTextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SimpleTextState();
  }
}

class SimpleTextState extends State<SimpleTextWidget> {

  late Future<PostResponse> post;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // post = PostApi.registerPost();
    post = PostApi.registerWithRetry();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('post api test'),
        ),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: FutureBuilder<PostResponse> (
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('post result : ${snapshot.data ?? ""}');

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("title :  ${snapshot.data?.title ?? ""}"),
                    Text("body :  ${snapshot.data?.body ?? "" }"),
                    Text("userId : ${snapshot.data?.userId ?? ""}"),
                    Text("id : ${snapshot.data?.id ?? ""}"),
                  ],
                );
                return Text(snapshot.data?.title ?? "");
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('${snapshot.error}')
                );
              }
              return CircularProgressIndicator();
            },
          ),
        )

    );

  }
}
