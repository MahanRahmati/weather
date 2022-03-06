import 'package:json_annotation/json_annotation.dart';

import "/models/current.dart";
import "/models/daily.dart";
import "/models/hourly.dart";

part 'forecast.g.dart';

@JsonSerializable(explicitToJson: true)
class Forecast {
  final double lat;
  final double lon;
  final String timezone;
  final double timezoneOffset;
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  Forecast({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}
