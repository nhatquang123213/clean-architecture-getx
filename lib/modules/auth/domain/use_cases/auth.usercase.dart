import 'package:code_base/common/configs/usecase.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:code_base/modules/auth/domain/repositories/auth.repository.dart';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

@injectable
class UserLoginUseCase
    implements UseCase<UserLoginResponseEntity, UserLoginParam> {
  final IAuthRepository repository;

  UserLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserLoginResponseEntity>> call(
      UserLoginParam user) async {
    return await repository.loginUser(user);
  }
}
