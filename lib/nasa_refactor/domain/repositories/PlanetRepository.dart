
import '../entities/Planet.dart';
// data layer 가 변경되더라도 domain 영역은 dependency 없이 동작할 수 있게끔 abstract class로 선언.
abstract class PlanetRepository {
  Future<PlanetResponse> getPlanetData();
}