import 'package:code_base/common/configs/usecase.dart';
import 'package:code_base/modules/auth/data/models/auth.model.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:code_base/services/http/http.sevice.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IAuthDataSource {
  Future<Either<Failure, UserLoginResponseModel>> loginUser(
      UserLoginParam user);

  Future<Either<Failure, UserModel>> getProfile();
}

@Injectable(as: IAuthDataSource)
class AuthDataSource implements IAuthDataSource {
  @override
  Future<Either<Failure, UserLoginResponseModel>> loginUser(
      UserLoginParam user) async {
    try {
      final response = await HttpService.instance.post("/login", data: user);
      return Right(UserLoginResponseModel.fromJson(response.data));
    } catch (e) {
      return Left(SystemFailure(error: ErrorEntity()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final response = await HttpService.instance.get("/user");
      return Right(UserModel.fromJson(response.data));
    } catch (e) {
      return Left(SystemFailure(error: ErrorEntity()));
    }
  }
}
