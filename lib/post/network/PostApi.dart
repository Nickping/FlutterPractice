import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import '../model/Post.dart';
import 'dart:math' as math;


class PostApi {

    // retry handler 없이 호출 ( post method )
    static Future<PostResponse> registerPost() async {
      String url = "https://jsonplaceholder.typicode.com/posts";
      var uri = Uri.parse(url);
      final client = http.Client();
      final response = await client.post(
          uri,
          headers: <String, String> {
            'Content-Type': 'application/json',
          },
          body: json.encode(<String, dynamic> {
            "title" : "hello world",
            "body" : "flutter",
            "userId" : 59,
            "id": 10
          })
      ).timeout(  // http package가 아닌 Future<T> 에서 제공하는 timeout handler
          const Duration(seconds: 10),
        onTimeout: () {
            throw Exception('request timeout');
        }
      );

      try {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          print(response.body);
          return PostResponse.fromJson(json.decode(response.body));
        } else {
          throw Exception('failed to register post');
        }
      } finally {
        // client 사용시 반드시 close를 호출 한다. 그렇지 않을 경우 resource hang 발생 가능.
        client.close();
      }
    }

    // retry handler 적용 후 호출 ( post method )
    static Future<PostResponse> registerWithRetry() async {
      // String url = "https://jsonplaceholder.typicode.com/posts"; // original url
      String url = "https://jsonplaceholder.typicode.com/post"; // invalid url
      var uri = Uri.parse(url);

      final client = RetryClient(
        http.Client(),
        retries: 3,
        delay: (retryCount) { // default 0.5 * 1.5 제곱 씩 증가
          return const Duration(milliseconds: 300) * math.pow(1.5, retryCount);

        },
        when: (response) {
          return response.statusCode == 404;
        },
        onRetry: (request, response, retryCount) {
          print('current count : ${retryCount}');
        }
      );

      final response = await client.post(
          uri,
          headers: <String, String> {
            'Content-Type': 'application/json',
          },
          body: json.encode(<String, dynamic> {
            "title" : "hello world",
            "body" : "flutter",
            "userId" : 59,
            "id": 10
          })
      ).timeout(  // http package가 아닌 Future<T> 에서 제공하는 timeout handler
          const Duration(seconds: 10),
          onTimeout: () {
            throw Exception('request timeout');
          }
      );

      try {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          print(response.body);
          return PostResponse.fromJson(json.decode(response.body));
        } else {
          throw Exception('failed to register post');
        }
      } finally {
        // client 사용시 반드시 close를 호출 한다. 그렇지 않을 경우 resource hang 발생 가능.
        client.close();
      }
    }
}