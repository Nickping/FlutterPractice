// Usecase 정리
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<T> {
  const BaseUseCase();
}

abstract class UseCase<T, P> extends BaseUseCase<T> {
  const UseCase() : super();
  Future<T> call(P params);
}

abstract class NoParamUseCase<T> extends BaseUseCase<T> {
  const NoParamUseCase() : super();
  Future<T> call();
}