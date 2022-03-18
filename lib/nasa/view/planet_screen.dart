import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Planet.dart';
class PlanetDetailWidget extends StatefulWidget {
  final Planet planet;
  PlanetDetailWidget({required this.planet});

  @override
  State<StatefulWidget> createState() {
    return PlanetDetailState(planet: planet);

  }
}

class PlanetDetailState extends State<PlanetDetailWidget> {

  final Planet planet;

  PlanetDetailState({required this.planet});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(


        navigationBar: CupertinoNavigationBar(
            leading: BaseBackButton(
              title: 'back',
            )
        ),
        child: Container(
          height: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 400,
                child: BaseNetworkImage(url: planet.hdurl ?? planet.url),
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: Divider(color: Colors.grey,)
              ),
              Text('Planet name : ${planet.title}'),
              Flexible(
                  fit: FlexFit.loose,
                  child: Divider(color: Colors.grey,)
              ),
              Text(planet.explanation)
            ],
          ),
        )
    );
  }
}




class BaseNetworkImage extends StatelessWidget {
  final String url;

  BaseNetworkImage({required this.url});

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Image>(
    //   future: _fetchImage(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return snapshot.data!;
    //     } else if (snapshot.hasError) {
    //       return Center(
    //         heightFactor: 3,
    //         child: Text('${snapshot.error}'),
    //       );
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );

    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }


  Future<Image> _fetchImage() async {
    return Image.network(url);
  }
}

class BaseBackButton extends StatelessWidget {
  final String title;

  BaseBackButton({
    required this.title,
    Key? key
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pop(context);
      },
      child: Text(title),
    );
  }

  _pop(BuildContext context) {
    Navigator.pop(context);
  }

}
