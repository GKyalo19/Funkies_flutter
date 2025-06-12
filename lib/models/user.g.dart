// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  name: json['name'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  password_confirmation: json['password_confirmation'] as String?,
  user_photo_url: json['user_photo_url'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'password_confirmation': instance.password_confirmation,
  'user_photo_url': instance.user_photo_url,
};
