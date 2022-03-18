import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:second_project/counter/provider/Counter.dart';
import 'package:second_project/counter/view/CounterHome.dart';
import 'package:second_project/nasa_refactor/presentation/presentationPackages.dart';
import 'package:second_project/nasa_refactor/presentation/view/nasa.dart';
import 'nasa/model/Planet.dart';
import 'nasa/view/nasa.dart';
import 'nasa/view/planet_screen.dart';

import 'post/model/Post.dart';
import 'post/network/PostApi.dart';
import 'post/view/postHome.dart';

void main() {
  // runApp(NasaHome());
  // runApp(CounterApp());
  // runApp(MultiProvider(
  //     providers: [
  //       // Provider(create: (context) => Counter(),)
  //       ChangeNotifierProvider(create: (_) => Counter())
  //     ],
  //   child: CounterApp(),
  //   )
  // );
  // runApp(NasaRefactorHome());
  runApp(ProviderScope(child: NasaRefactorHome()));
}
