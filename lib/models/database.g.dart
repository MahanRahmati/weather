// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseAdapter extends TypeAdapter<Database> {
  @override
  final int typeId = 0;

  @override
  Database read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Database(
      location: fields[0] as Location?,
      data: (fields[1] as Map?)?.cast<String, dynamic>(),
      dateTime: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Database obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
