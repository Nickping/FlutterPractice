

import 'dart:ffi';

import 'package:flutter/material.dart';
import '../domain/domainPackages.dart';
import '../data/dataPackages.dart';
import '../presentation/providers/providers.dart';
class PlanetState with ChangeNotifier {

  final FetchPlanetUseCase _fetchPlanetUseCase;
  PlanetState(this._fetchPlanetUseCase);

  List<Planet> planets = [];

  Future<bool> getPlanetData() async {

    PlanetResponse result = await _fetchPlanetUseCase();

    planets = result.list;

    notifyListeners();
    return true;
  }
}