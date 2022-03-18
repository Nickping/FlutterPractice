

import 'package:second_project/nasa_refactor/data/datasource/PlanetRemoteDataSource.dart';
import  '../../domain/domainPackages.dart';

// domain layer의 abstract class 구현체
class PlanetRepositoryImpl implements PlanetRepository {
  final PlanetRemoteDataSource remoteDataSource;

  PlanetRepositoryImpl({required this.remoteDataSource});


  Future<PlanetResponse> getPlanetData() async {
    return remoteDataSource.fetchWithRetryPlanetsData();
  }
}