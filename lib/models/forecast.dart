import '/models/daily.dart';
import '/models/hourly.dart';
import '/models/temperature.dart';
import '/utils/functions.dart';

class Forecast {
  Forecast(Map<String, dynamic> jsonData) {
    Map<String, dynamic>? current =
        jsonData['current']?.cast<String, dynamic>();
    Map<String, dynamic>? rain = current!['rain']?.cast<String, dynamic>();
    Map<String, dynamic>? snow = current['snow']?.cast<String, dynamic>();
    Map<String, dynamic>? weather =
        current['weather'][0]?.cast<String, dynamic>();
    List<dynamic>? hourly = jsonData['hourly'];
    List<dynamic>? daily = jsonData['daily'];

    _data = jsonData;
    _lat = unpackDouble(_data, 'lat');
    _lon = unpackDouble(_data, 'lon');
    _timezone = unpackString(_data, 'timezone');
    _timezoneOffset = unpackDouble(_data, 'timezone_offset');
    _date = unpackDate(current, 'dt');
    _sunrise = unpackDate(current, 'sunrise');
    _sunset = unpackDate(current, 'sunset');

    _temperature = unpackTemperature(current, 'temp');
    _tempFeelsLike = unpackTemperature(current, 'feels_like');
    _pressure = unpackDouble(current, 'pressure');
    _humidity = unpackDouble(current, 'humidity');
    _dewPoint = unpackDouble(current, 'dew_point');
    _clouds = unpackDouble(current, 'clouds');
    _uvi = unpackDouble(current, 'uvi');
    _visibility = unpackDouble(current, 'visibility');
    _windSpeed = unpackDouble(current, 'wind_speed');
    _windGust = unpackDouble(_data, 'wind_gust');
    _windDegree = unpackDouble(current, 'wind_deg');
    _weatherConditionCode = unpackInt(weather, 'id');
    _weatherMain = unpackString(weather, 'main');
    _weatherDescription = unpackString(weather, 'description');
    _weatherIcon = unpackString(weather, 'icon');
    _rain = unpackDouble(rain, '1h');
    _snow = unpackDouble(snow, '1h');
    if (hourly != null) {
      _hourly = hourly.map((e) => Hourly(e?.cast<String, dynamic>())).toList();
    }
    if (daily != null) {
      _daily = daily.map((e) => Daily(e?.cast<String, dynamic>())).toList();
    }
  }

  Map<String, dynamic>? _data;
  double? _lat;
  double? _lon;
  String? _timezone;
  double? _timezoneOffset;
  DateTime? _date;
  DateTime? _sunrise;
  DateTime? _sunset;
  Temperature? _temperature;
  Temperature? _tempFeelsLike;
  double? _pressure;
  double? _humidity;
  double? _dewPoint;
  double? _clouds;
  double? _uvi;
  double? _visibility;
  double? _windSpeed;
  double? _windGust;
  double? _windDegree;
  double? _rain;
  double? _snow;
  int? _weatherConditionCode;
  String? _weatherMain;
  String? _weatherDescription;
  String? _weatherIcon;
  List<Hourly?>? _hourly;
  List<Daily?>? _daily;

  Map<String, dynamic>? toJson() => _data;

  double? get lat => _lat;
  double? get lon => _lon;
  String? get timezone => _timezone;
  double? get timezoneOffset => _timezoneOffset;
  DateTime? get date => _date;
  DateTime? get sunrise => _sunrise;
  DateTime? get sunset => _sunset;
  Temperature? get temperature => _temperature;
  Temperature? get tempFeelsLike => _tempFeelsLike;
  double? get pressure => _pressure;
  double? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get clouds => _clouds;
  double? get uvi => _uvi;
  double? get visibility => _visibility;
  double? get windSpeed => _windSpeed;
  double? get windGust => _windGust;
  double? get windDegree => _windDegree;
  double? get rain => _rain;
  double? get snow => _snow;
  int? get weatherConditionCode => _weatherConditionCode;
  String? get weatherMain => _weatherMain;
  String? get weatherDescription => _weatherDescription;
  String? get weatherIcon => _weatherIcon;
  List<Hourly?>? get hourly => _hourly;
  List<Daily?>? get daily => _daily;
}
