import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/forecast.dart';
import '/models/location.dart';

String getApiKey() {
  return "";
}

String getUnits() {
  return "metric"; //TODO Add Units
}

Future fetchData(context) async {} //TODO Add FetchData

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

Future<Forecast?> getForecast(Location location) async {
  try {
    final response = await http
        .get(
          Uri.https(
            "api.openweathermap.org",
            "/data/2.5/onecall",
            {
              "lat": location.lat.toString(),
              "lon": location.lon.toString(),
              "exclude": "minutely",
              "units": getUnits(),
              "appid": getApiKey(),
            },
          ),
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      Forecast.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      Forecast forecast = Forecast.fromJson(json.decode(response.body));
      return forecast;
    } else {
      throw "Error code: ${response.statusCode} ";
    }
  } catch (_) {}
  return null;
}
