import 'package:code_base/common/configs/usecase.dart';
import 'package:code_base/modules/auth/data/datasources/auth.datasource.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:code_base/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IAuthDataSource userDataSource;

  AuthRepository({required this.userDataSource});

  @override
  Future<Either<Failure, UserLoginResponseEntity>> loginUser(
      UserLoginParam param) async {
    ///convert model to entity
    return await userDataSource
        .loginUser(param)
        .then((value) => value.map((r) => r.toEntity()));
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    return await userDataSource
        .getProfile()
        .then((value) => value.map((r) => r.toEntity()));
  }
}
