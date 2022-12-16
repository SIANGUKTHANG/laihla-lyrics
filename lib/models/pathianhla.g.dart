// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pathianhla.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PathianHlaModelAdapter extends TypeAdapter<PathianHlaModel> {
  @override
  final int typeId = 1;

  @override
  PathianHlaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PathianHlaModel(
      title: fields[0] as dynamic,
      composer: fields[1] as dynamic,
      singer: fields[2] as dynamic,
      verse2: fields[4] as dynamic,
      verse3: fields[5] as dynamic,
      verse4: fields[6] as dynamic,
      verse5: fields[7] as dynamic,
      chorus: fields[9] as dynamic,
      verse1: fields[3] as dynamic,
    )
      ..prechorus = fields[8] as dynamic
      ..endingchorus = fields[10] as dynamic;
  }

  @override
  void write(BinaryWriter writer, PathianHlaModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.composer)
      ..writeByte(2)
      ..write(obj.singer)
      ..writeByte(3)
      ..write(obj.verse1)
      ..writeByte(4)
      ..write(obj.verse2)
      ..writeByte(5)
      ..write(obj.verse3)
      ..writeByte(6)
      ..write(obj.verse4)
      ..writeByte(7)
      ..write(obj.verse5)
      ..writeByte(8)
      ..write(obj.prechorus)
      ..writeByte(9)
      ..write(obj.chorus)
      ..writeByte(10)
      ..write(obj.endingchorus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PathianHlaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
