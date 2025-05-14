import 'package:json_annotation/json_annotation.dart';

part 'mpesa.g.dart';

@JsonSerializable()
class MPesa {
  MPesa({
    required this.phone,
    required this.event_id,
    required this.transaction_desc
  });

  final String phone;
  final int event_id;
  final String transaction_desc;

  factory MPesa.fromJson(Map<String, dynamic> json) => _$MPesaFromJson(json);

  Map<String, dynamic> toJson() => _$MPesaToJson(this);
}