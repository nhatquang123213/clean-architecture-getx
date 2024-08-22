import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  // Convert UserEntity to UserModel
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      avatar: entity.avatar,
    );
  }

  // Convert UserModel to UserEntity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      avatar: avatar,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(createToJson: false)
class UserLoginResponseModel {
  String accessToken;
  String refreshToken;

  UserLoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  // Convert UserModel to UserEntity
  UserLoginResponseEntity toEntity() {
    return UserLoginResponseEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseModelFromJson(json);
}
