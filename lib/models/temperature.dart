/// A class for holding a temperature.
/// Can output temperature as Kelvin, Celsius or Fahrenheit.
/// All results are returned as [double].
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_domain.dart
class Temperature {
  Temperature(this._celsius);

  final double? _celsius;

  double? get kelvin => _celsius != null ? _celsius! + 273.15 : null;

  double? get celsius => _celsius;

  double? get fahrenheit => _celsius != null ? (_celsius! * 1.8) + 32 : null;
}
