import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 1)
class Location {
  Location({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String country;

  @HiveField(2)
  final double lat;

  @HiveField(3)
  final double lon;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'] as String,
        country: json['country'] as String,
        lat: (json['lat'] as num).toDouble(),
        lon: (json['lon'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'country': country,
        'lat': lat,
        'lon': lon,
      };
}
