
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:math' as math;
import '../../domain/domainPackages.dart';


abstract class PlanetRemoteDataSource {
  Future<PlanetResponse> fetchWithRetryPlanetsData();
}

class PlanetRemoteDataSourceImpl implements PlanetRemoteDataSource {
  @override
  Future<PlanetResponse> fetchWithRetryPlanetsData() async {
    print('fetchWithRetryPlantesData');


    final client = RetryClient(
        http.Client(),
        retries: 3, // default 3번 요청
        delay: (retryCount) { // retry 간 delay time. default 0.5초 * (count)^1.5 씩 증가
          return const Duration(milliseconds: 300) * math.pow(1.5, retryCount);

        },
        when: (response) {
          return response.statusCode == 404; // when function을 따로 등록하지 않을 경우 503 에러일 경우에만 true return 및 retry 로직 동작
          //     return response.statusCode == 403;
        },
        onRetry: (request, response, count) { // request, response, retryCount
          print('current count : ${count}');
        }
    );
    try {
      String url = 'https://api.nasa.gov/planetary/apod?api_key=08GgcEo65e6npMJyfwXlVOQcxcKmSQmYGt3Pmr6a&count=10&thumbs=true'; // original
      // String url = 'https://api.nasa.gov/planetary/apod?api_key=08GgcEo65e6npMJyfwXlVOQcxcKmSQmYGt3Pmr6&count=10&thumbs=true'; // invalid token
      // String url = 'https://api.nasa.gov/planetary/apo?api_key=08GgcEo65e6npMJyfwXlVOQcxcKmSQmYGt3Pmr6a&count=10&thumbs=true'; // invalid path
      var uri = Uri.parse(url);
      final response = await client.get(uri)
          .timeout( // http package가 아닌 Future<T> 에서 제공하는 timeout handler
          const Duration(seconds: 10),
          onTimeout: () {
            throw Exception('request timeout');
          }
      );


      if (response.statusCode >= 200 && response.statusCode < 300) {
        // var list = PlanetResponse.fromJson(json.decode(response.body)).list;

        return PlanetResponse.fromJson(json.decode(response.body));
      } else {
        print('error ocured : ${createHttpError(response.statusCode).description}');
        throw Exception(createHttpError(response.statusCode).description);
      }
    } finally {
      // client 사용시 반드시 close를 호출 한다. 그렇지 않을 경우 resource hang 발생 가능.
      client.close();
    }

  }
}


enum NetworkErrorType {
  forbidden, // 403
  notfound, // 404
  unknown // unknown
}



extension NetworkErrorExtension on NetworkErrorType {
  String get description => describeEnum(this);
}

NetworkErrorType createHttpError(int statusCode) {
  switch (statusCode) {
    case 403:
      return NetworkErrorType.forbidden;
    case 404:
      return NetworkErrorType.notfound;
    default:
      return NetworkErrorType.unknown;

  }
}
