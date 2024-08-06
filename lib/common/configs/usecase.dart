import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Failure {
  final ErrorEntity? error;

  Failure({this.error});
  String? get message => error?.message;
}

class SystemFailure extends Failure {
  SystemFailure({ErrorEntity? error}) : super(error: error);
}

class CacheFailure extends Failure {
  CacheFailure({ErrorEntity? error}) : super(error: error);
}

class ErrorEntity {
  final int? statusCode;
  final String? message;

  ErrorEntity({this.statusCode, this.message});
}
