// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpesa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MPesa _$MPesaFromJson(Map<String, dynamic> json) => MPesa(
  phone: json['phone'] as String,
  event_id: (json['event_id'] as num).toInt(),
  event_name: json['event_name'] as String,
  transaction_desc: json['transaction_desc'] as String,
);

Map<String, dynamic> _$MPesaToJson(MPesa instance) => <String, dynamic>{
  'phone': instance.phone,
  'event_id': instance.event_id,
  'event_name': instance.event_name,
  'transaction_desc': instance.transaction_desc,
};
