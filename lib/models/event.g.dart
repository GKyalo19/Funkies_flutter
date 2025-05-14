// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  id: (json['id'] as num?)?.toInt(),
  posterUrl: json['poster'] as String?,
  eventClass: json['eventClass'] as String?,
  level: json['level'] as String?,
  category: json['category'] as String?,
  subject: json['subject'] as String?,
  name: json['name'] as String?,
  participation_mode: json['participation_mode'] as String?,
  venue: json['venue'] as String?,
  link: json['link'] as String?,
  county: json['county'] as String?,
  description: json['description'] as String?,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  hosts: json['hosts'] as String?,
  sponsors: json['sponsors'] as String?,
  capacity: (json['capacity'] as num?)?.toInt(),
  registration_fee: (json['registration_fee'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  isLiked: json['isLiked'] as bool? ?? false,
  isPaid: json['isPaid'] as bool? ?? false,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'isLiked': instance.isLiked,
  'isPaid': instance.isPaid,
  'id': instance.id,
  'poster': instance.posterUrl,
  'eventClass': instance.eventClass,
  'level': instance.level,
  'category': instance.category,
  'subject': instance.subject,
  'name': instance.name,
  'participation_mode': instance.participation_mode,
  'venue': instance.venue,
  'link': instance.link,
  'county': instance.county,
  'description': instance.description,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'hosts': instance.hosts,
  'sponsors': instance.sponsors,
  'capacity': instance.capacity,
  'registration_fee': instance.registration_fee,
  'currency': instance.currency,
  'userId': instance.userId,
};
