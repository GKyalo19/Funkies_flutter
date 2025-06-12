import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    this.name,
    required this.email,
    required this.password,
    this.password_confirmation,
    this.user_photo,
    this.user_photo_url
  });

  final String? name;
  final String? email;
  final String? password;
  final String? password_confirmation;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? user_photo;

  @JsonKey(name: 'user_photo_url')
  final String? user_photo_url;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class AuthResponse {
  AuthResponse({required this.user, required this.token, required this.userId});

  final User user;
  final String token;
  final int userId;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    print("AUTH JSON: $json");
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'],
      userId: (json['user'] as Map<String, dynamic>)['id'],
    );
  }
}
