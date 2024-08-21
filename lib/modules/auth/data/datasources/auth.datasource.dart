import 'package:code_base/common/configs/usecase.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:code_base/modules/services/http/http.sevice.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IAuthDataSource {
  Future<Either<Failure, UserLoginResponseEntity>> loginUser(
      UserLoginParam user);

  Future<Either<Failure, UserEntity>> getProfile();
}

@Injectable(as: IAuthDataSource)
class AuthDataSource implements IAuthDataSource {
  @override
  Future<Either<Failure, UserLoginResponseEntity>> loginUser(
      UserLoginParam user) async {
    try {
      final response = await HttpService.instance.post("/login", data: user);
      return Right(UserLoginResponseEntity.fromJson(response.data));
    } catch (e) {
      return Left(SystemFailure(error: ErrorEntity()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final response = await HttpService.instance.get("/user");
      return Right(UserEntity.fromJson(response.data));
    } catch (e) {
      return Left(SystemFailure(error: ErrorEntity()));
    }
  }
}
