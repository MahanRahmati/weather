import 'package:json_annotation/json_annotation.dart';

import '/models/weather.dart';

part 'hourly.g.dart';

@JsonSerializable(explicitToJson: true)
class Hourly {
  final double? dt;
  final double? temp;
  final double? feelsLike;
  final double? pressure;
  final double? humidity;
  final double? dewPoint;
  final double? uvi;
  final double? clouds;
  final double? visibility;
  final double? windSpeed;
  final double? windDeg;
  final double? windGust;
  final List<Weather>? weather;
  final double? pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
