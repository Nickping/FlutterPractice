
import '../domainPackages.dart';
import '../../domain/domainPackages.dart';

class FetchPlanetUseCase implements NoParamUseCase<PlanetResponse> {

  final PlanetRepository planetRepository;
  FetchPlanetUseCase({required this.planetRepository});

  @override
  Future<PlanetResponse> call() async{
    return planetRepository.getPlanetData();
  }


}