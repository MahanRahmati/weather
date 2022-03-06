import 'package:json_annotation/json_annotation.dart';

// import '/models/feel.dart';
import '/models/temp.dart';
import '/models/weather.dart';

part 'daily.g.dart';

//TODO Fix Daily
@JsonSerializable(explicitToJson: true)
class Daily {
  final double? dt;
  final double? sunrise;
  final double? sunset;
  final double? moonrise;
  final double? moonset;
  final double? moonPhase;
  final Temp? temp;
  // final FeelsLike? feelsLike;
  // final double? pressure;
  // final double? humidity;
  // final double? dewPoint;
  // final double? windSpeed;
  // final double? windDeg;
  // final double? windGust;
  final List<Weather>? weather;
  // final double? clouds;
  // final double? pop;
  // final double? uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    // this.feelsLike,
    // this.pressure,
    // this.humidity,
    // this.dewPoint,
    // this.windSpeed,
    // this.windDeg,
    // this.windGust,
    this.weather,
    // this.clouds,
    // this.pop,
    // this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
