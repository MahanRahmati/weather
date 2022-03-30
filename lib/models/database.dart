import 'package:hive/hive.dart';

import '/models/location.dart';

part 'database.g.dart';

@HiveType(typeId: 0)
class Database {
  Database({
    required this.location,
    required this.data,
    required this.dateTime,
  });

  @HiveField(0)
  Location? location;

  @HiveField(1)
  Map<String, dynamic>? data;

  @HiveField(2)
  DateTime? dateTime;
}
