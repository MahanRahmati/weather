import 'dart:convert';

import 'package:arna/arna.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '/models/database.dart';
import '/models/forecast.dart';
import '/models/location.dart';
import '/models/temperature.dart';

String getApiKey() {
  return "";
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Color circleBackgroundColor(BuildContext context) {
  return ArnaTheme.brightnessOf(context) == Brightness.light
      ? const Color(0x21000000)
      : const Color(0x21FFFFFF);
}

List<Color> backgroundColor(DateTime date, double timezoneOffset) {
  int t1 = (date.hour * 3600) + (date.minute * 60);
  int t2 = timezoneOffset.toInt();
  double t3 = (t1 + t2) / 3600;

  int time = t3.toInt();

  if (time >= 20 || time < 7) {
    return [const Color(0xFF032253), const Color(0xFF001528)];
  }

  if (time >= 7 && time < 12) {
    return [const Color(0xFF68CBC8), const Color(0xFF1F8EAA)];
  }

  if (time >= 12 && time < 17) {
    return [const Color(0xFFFDA65A), const Color(0xFFFFDC64)];
  }

  if (time >= 17 && time < 20) {
    return [const Color(0xFF3C1E78), const Color(0xFF693282)];
  }

  return [ArnaColors.errorColor, ArnaColors.errorColor];
}

Future searchLocation(String query) async {
  try {
    final response = await http
        .get(
          Uri.https(
            "api.openweathermap.org",
            "/geo/1.0/direct",
            {"q": query, "limit": "5", "appid": getApiKey()},
          ),
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      List<Location> locations = [];
      for (var location in json.decode(response.body)) {
        locations.add(Location.fromJson(location));
      }
      return locations;
    } else {
      throw "Error code: ${response.statusCode} ";
    }
  } catch (_) {}
  return null;
}

Future<Forecast> forecastByLocation(
  Box<Database>? db,
  Location location,
) async {
  List<int>? keys = db!.keys.cast<int>().toList();
  if (keys.isNotEmpty) {
    for (int i = 0; i < keys.length; i++) {
      int key = keys[i];
      final Database? database = db.get(key);
      if (database != null) {
        if (database.location != null) {
          if (database.location!.lat == location.lat &&
              database.location!.lon == location.lon) {
            if (database.dateTime != null) {
              if (database.dateTime!.difference(DateTime.now()) <
                  const Duration(hours: 1)) {
                if (database.data != null) {
                  return Forecast(database.data!);
                }
              }
            }
          }
        }
      }
    }
  }
  Map<String, dynamic>? jsonResponse = await sendRequest(
    lat: location.lat,
    lon: location.lon,
  );
  return Forecast(jsonResponse!);
}

Future<Map<String, dynamic>?> sendRequest({
  double? lat,
  double? lon,
  String? cityName,
}) async {
  /// Send HTTP get response with the url
  http.Response response = await http.Client().get(
    Uri.https(
      "api.openweathermap.org",
      "/data/2.5/onecall",
      {
        "lat": lat.toString(),
        "lon": lon.toString(),
        "exclude": "minutely",
        "units": "metric",
        "appid": getApiKey(),
      },
    ),
  );

  /// Perform error checking on response:
  /// Status code 200 means everything went well
  if (response.statusCode == 200) {
    Map<String, dynamic>? jsonBody = json.decode(response.body);
    return jsonBody;
  }

  /// The API key is invalid, the API may be down
  /// or some other unspecified error could occur.
  /// The concrete error should be clear from the HTTP response body.
  else {
    throw OpenWeatherAPIException(
      "The API threw an exception: ${response.body}",
    );
  }
}

/// Safely unpack an integer value from a [Map] object.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_parsing.dart
int? unpackInt(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val is String) {
        return int.parse(val);
      } else if (val is int) {
        return val;
      }
      return -1;
    }
  }
  return null;
}

/// Safely unpack a double value from a [Map] object.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_parsing.dart
double? unpackDouble(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val is String) {
        return double.parse(val);
      } else if (val is num) {
        return val.toDouble();
      }
    }
  }
  return null;
}

/// Safely unpack a string value from a [Map] object.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_parsing.dart
String? unpackString(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k];
    }
  }
  return null;
}

/// Safely unpacks a unix timestamp from a [Map] object,
/// i.e. an integer value of milliseconds and converts this to a [DateTime] object.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_parsing.dart
DateTime? unpackDate(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      int millis = M[k] * 1000;
      return DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
    }
  }
  return null;
}

/// Unpacks a [double] value from a [Map] object and converts this to
/// a [Temperature] object.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/weather_parsing.dart
Temperature unpackTemperature(Map<String, dynamic>? M, String k) {
  double? kelvin = unpackDouble(M, k);
  return Temperature(kelvin);
}

/// Thrown whenever the API responds with an error and body could not be parsed.
/// Based on https://github.com/cph-cachet/flutter-plugins/blob/master/packages/weather/lib/src/exceptions.dart
class OpenWeatherAPIException implements Exception {
  final String _cause;

  OpenWeatherAPIException(this._cause);

  @override
  String toString() => '$runtimeType - $_cause';
}

Future addToDatabase(
  Box<Database>? db,
  Forecast? forecast,
  Location location,
) async {
  bool exist = false;
  if (forecast != null) {
    List<int>? keys = db!.keys.cast<int>().toList();
    if (keys.isNotEmpty) {
      for (int i = 0; i < keys.length; i++) {
        int key = keys[i];
        final Database? database = db.get(key);
        if (database != null) {
          if (database.location != null) {
            if (database.location!.lat == location.lat &&
                database.location!.lon == location.lon) {
              exist = true;
            }
          }
        }
      }
    }
    if (!exist) {
      await db.add(
        Database(
          location: location,
          data: forecast.toJson(),
          dateTime: DateTime.now(),
        ),
      );
    }
  }
}
