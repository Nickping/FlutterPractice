
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:math' as math;



class Planet {
  final String? copyright;
  final String date;
  final String explanation;
  final String? hdurl;
  final String title;
  final String url;

  Planet({this.copyright = "", this.date = "", this.explanation = "", this.hdurl,
    this.title = "", this.url = ""});

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
        copyright: json['copyright'],
        date: json['date'],
        explanation: json['explanation'],
        hdurl: json['hdurl'],
        title: json['title'],
        url: json['url']
    );
  }

}

class PlanetResponse {
  final List<Planet> list;

  PlanetResponse({required this.list});

  factory PlanetResponse.fromJson(List<dynamic> json) {
    print('response init');
    List<Planet> tempList = [];

    json.forEach((element) {
      print(element);
      var item = element as Map<String, dynamic>;
      tempList.add(Planet.fromJson(item));
    });

    return PlanetResponse(list: tempList);
  }

}
