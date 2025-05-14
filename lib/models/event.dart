import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  Event({
    this.id,
    this.posterUrl,
    this.poster,
    required this.eventClass,
    required this.level,
    required this.category,
    required this.subject,
    required this.name,
    required this.participation_mode,
    this.venue,
    this.link,
    this.county,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.hosts,
    required this.sponsors,
    required this.capacity,
    required this.registration_fee,
    required this.currency,
    this.userId,
    this.isLiked = false,
    this.isPaid = false,
  });

  @JsonKey(name: 'isLiked')
  bool? isLiked;

  @JsonKey(name: 'isPaid')
  bool? isPaid;

  final int? id;

  @JsonKey(name: 'poster')
  final String? posterUrl;

  final String? eventClass;
  final String? level;
  final String? category;
  final String? subject;
  final String? name;
  final String? participation_mode;
  final String? venue;
  final String? link;
  final String? county;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? hosts;
  final String? sponsors;
  final int? capacity;
  final int? registration_fee;
  final String? currency;
  final int? userId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? poster;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Map<String, String> toMultipartFields() {
    final data = toJson();
    final fields = <String, String>{};

    data.forEach((key, value){
      if(value != null){
        if(value is DateTime){
          fields[key] = value.toIso8601String();
        } else {
          fields[key] = value.toString();
        }
      }
    });

    return fields;
  }
}
