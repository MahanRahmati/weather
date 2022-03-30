import '/models/temperature.dart';
import '/utils/functions.dart';

class Hourly {
  Hourly(Map<String, dynamic> jsonData) {
    Map<String, dynamic>? weather =
        jsonData['weather'][0]?.cast<String, dynamic>();
    Map<String, dynamic>? rain = jsonData['rain']?.cast<String, dynamic>();
    Map<String, dynamic>? snow = jsonData['snow']?.cast<String, dynamic>();

    _data = jsonData;
    _date = unpackDate(_data, 'dt');
    _temperature = unpackTemperature(_data, 'temp');
    _tempFeelsLike = unpackTemperature(_data, 'feels_like');
    _pressure = unpackDouble(_data, 'pressure');
    _humidity = unpackDouble(_data, 'humidity');
    _dewPoint = unpackDouble(_data, 'dew_point');
    _uvi = unpackDouble(_data, 'uvi');
    _clouds = unpackDouble(_data, 'clouds');
    _visibility = unpackDouble(_data, 'visibility');
    _windSpeed = unpackDouble(_data, 'wind_speed');
    _windGust = unpackDouble(_data, 'wind_gust');
    _windDegree = unpackDouble(_data, 'wind_deg');
    _pop = unpackDouble(_data, 'pop');
    _rain = unpackDouble(rain, '1h');
    _snow = unpackDouble(snow, '1h');
    _weatherConditionCode = unpackInt(weather, 'id');
    _weatherMain = unpackString(weather, 'main');
    _weatherDescription = unpackString(weather, 'description');
    _weatherIcon = unpackString(weather, 'icon');
  }

  Map<String, dynamic>? _data;
  DateTime? _date;
  Temperature? _temperature;
  Temperature? _tempFeelsLike;
  double? _pressure;
  double? _humidity;
  double? _dewPoint;
  double? _uvi;
  double? _clouds;
  double? _visibility;
  double? _windSpeed;
  double? _windGust;
  double? _windDegree;
  double? _pop;
  double? _rain;
  double? _snow;
  int? _weatherConditionCode;
  String? _weatherMain;
  String? _weatherDescription;
  String? _weatherIcon;

  Map<String, dynamic>? toJson() => _data;

  DateTime? get date => _date;
  Temperature? get temperature => _temperature;
  Temperature? get tempFeelsLike => _tempFeelsLike;
  double? get pressure => _pressure;
  double? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get uvi => _uvi;
  double? get clouds => _clouds;
  double? get visibility => _visibility;
  double? get windSpeed => _windSpeed;
  double? get windGust => _windGust;
  double? get windDegree => _windDegree;
  double? get pop => _pop;
  double? get rain => _rain;
  double? get snow => _snow;
  int? get weatherConditionCode => _weatherConditionCode;
  String? get weatherMain => _weatherMain;
  String? get weatherDescription => _weatherDescription;
  String? get weatherIcon => _weatherIcon;
}
