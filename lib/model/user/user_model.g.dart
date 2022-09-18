// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class userModelAdapter extends TypeAdapter<userModel> {
  @override
  final int typeId = 7;

  @override
  userModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return userModel()
      ..userName = fields[0] as String
      ..profilePic = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, userModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.profilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is userModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
