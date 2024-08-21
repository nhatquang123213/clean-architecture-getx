// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:code_base/modules/auth/data/datasources/auth.datasource.dart'
    as _i3;
import 'package:code_base/modules/auth/data/repositories/auth.repository.dart'
    as _i5;
import 'package:code_base/modules/auth/domain/repositories/auth.repository.dart'
    as _i4;
import 'package:code_base/modules/auth/domain/use_cases/auth.usercase.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.IAuthDataSource>(() => _i3.AuthDataSource());
    gh.factory<_i4.IAuthRepository>(
        () => _i5.AuthRepository(userDataSource: gh<_i3.IAuthDataSource>()));
    gh.factory<_i6.UserLoginUseCase>(
        () => _i6.UserLoginUseCase(repository: gh<_i4.IAuthRepository>()));
    return this;
  }
}
