import 'package:code_base/common/configs/usecase.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserLoginResponseEntity>> loginUser(
      UserLoginParam user);
  Future<Either<Failure, UserEntity>> getProfile();
}
