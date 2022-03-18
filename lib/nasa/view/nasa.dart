
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/nasa/network/NasaApi.dart';
import 'package:http/http.dart' as http;
import 'package:second_project/post/network/PostApi.dart';
import 'package:second_project/main.dart';
import 'package:second_project/nasa/view/planet_screen.dart';
import '../model/Planet.dart';
import '../../post/model/Post.dart';

class NasaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
        // title: "Nasa today's picture",
        home: PlanetListWidget()
      // home: SimpleTextWidget()
    );

  }
}

class PlanetListWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PlanetListState();
  }
}

class PlanetListState extends State<PlanetListWidget> {
  late Future<PlanetResponse> planet;

  @override
  void initState() {
    super.initState();
    // planet = NasaApi.fetchPlantesData();
    planet = NasaApi.fetchWithRetryPlantesData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Nasa todays picture')
    ),
      child: FutureBuilder<PlanetResponse>(
        future: planet,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('planets count: ${snapshot.data?.list.length}');
            return createListView(context, snapshot.data?.list ?? []);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}')
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget createListView(BuildContext context, List<Planet> planets) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              didTapCell(index);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => PlanetDetailWidget(planet: planets.elementAt(index)))
              );
            },
            child: createListCell(context, planets.elementAt(index)),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
          );
        },
        itemCount: planets.length
    );
  }

  didTapCell(int index) {
    print('flutter $index');

  }

  Widget createListCell(BuildContext context, Planet planet) {
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(planet.title),
          ),
          Expanded(
              child: Text(planet.date)
          )
        ],
      ),
    );
  }
}
