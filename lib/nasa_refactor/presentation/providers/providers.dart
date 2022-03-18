

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:second_project/nasa_refactor/data/datasource/PlanetRemoteDataSource.dart';
import 'package:second_project/nasa_refactor/data/repositories/PlanetRepositoryImpl.dart';
import 'package:second_project/nasa_refactor/domain/usecase/FetchPlanetUseCase.dart';
import 'package:second_project/nasa_refactor/presentation/states.dart';
import '../../domain/domainPackages.dart';
import '../../data/dataPackages.dart';
// provider top level 정의

final planetDataSourceProvider = Provider<PlanetRemoteDataSource>((ref) => PlanetRemoteDataSourceImpl());

final planetRespositoryProvider = Provider<PlanetRepository>((ref) {
  var dataSource = ref.watch(planetDataSourceProvider);

  return PlanetRepositoryImpl(remoteDataSource: dataSource);
});

final planetProvider = Provider<FetchPlanetUseCase>((ref) {
  var repository = ref.watch(planetRespositoryProvider);
  return FetchPlanetUseCase(planetRepository: repository);
},);

final planetStateProvider = ChangeNotifierProvider<PlanetState>((ref) {
  var usecase = ref.watch(planetProvider);
  return PlanetState(usecase);
},);