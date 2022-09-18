// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class transactionmodelAdapter extends TypeAdapter<transactionmodel> {
  @override
  final int typeId = 3;

  @override
  transactionmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return transactionmodel(
      Purpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as CategoryType,
      category: fields[4] as CategoryModel,
      imagePath: fields[5] as String?,
    )..id = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, transactionmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.Purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is transactionmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
