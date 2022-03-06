// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lon'] as num).toDouble(),
    timezone: json['timezone'] as String,
    timezoneOffset: (json['timezone_offset'] as num).toDouble(),
    current: Current.fromJson(json['current'] as Map<String, dynamic>),
    hourly: (json['hourly'] as List<dynamic>)
        .map((e) => Hourly.fromJson(e as Map<String, dynamic>))
        .toList(),
    daily: (json['daily'] as List<dynamic>)
        .map((e) => Daily.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'timezone_offset': instance.timezoneOffset,
      'current': instance.current.toJson(),
      'hourly': instance.hourly.map((e) => e.toJson()).toList(),
      'daily': instance.daily.map((e) => e.toJson()).toList(),
    };
