import 'package:json_annotation/json_annotation.dart';

part 'auth.entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int id;
  final String name;
  final String avatar;

  UserEntity({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

class UserLoginParam {
  String username;
  String password;

  UserLoginParam({
    required this.username,
    required this.password,
  });
}

@JsonSerializable(createToJson: false)
class UserLoginResponseEntity {
  String accessToken;
  String refreshToken;

  UserLoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseEntityFromJson(json);
}
