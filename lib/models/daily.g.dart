// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      dt: (json['dt'] as num?)?.toDouble(),
      sunrise: (json['sunrise'] as num?)?.toDouble(),
      sunset: (json['sunset'] as num?)?.toDouble(),
      moonrise: (json['moonrise'] as num?)?.toDouble(),
      moonset: (json['moonset'] as num?)?.toDouble(),
      moonPhase: (json['moon_phase'] as num?)?.toDouble(),
      temp: json['temp'] == null
          ? null
          : Temp.fromJson(json['temp'] as Map<String, dynamic>),
      // feelsLike: json['feels_like'] == null
      //     ? null
      //     : FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
      // pressure: (json['pressure'] as num?)?.toDouble(),
      // humidity: (json['humidity'] as num?)?.toDouble(),
      // dewPoint: (json['dew_point'] as num?)?.toDouble(),
      // windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      // windDeg: (json['wind_deg'] as num?)?.toDouble(),
      // windGust: (json['wind_gust'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      // clouds: (json['clouds'] as num?)?.toDouble(),
      // pop: (json['pop'] as double?)?.toDouble(),
      // uvi: (json['uvi'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moon_phase': instance.moonPhase,
      'temp': instance.temp?.toJson(),
      // 'feels_like': instance.feelsLike?.toJson(),
      // 'pressure': instance.pressure,
      // 'humidity': instance.humidity,
      // 'dew_point': instance.dewPoint,
      // 'wind_speed': instance.windSpeed,
      // 'wind_deg': instance.windDeg,
      // 'wind_gust': instance.windGust,
      'weather': instance.weather?.map((e) => e.toJson()).toList(),
      // 'clouds': instance.clouds,
      // 'pop': instance.pop,
      // 'uvi': instance.uvi,
    };
