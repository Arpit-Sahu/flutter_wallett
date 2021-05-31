// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionClassAdapter extends TypeAdapter<TransactionClass> {
  @override
  final int typeId = 0;

  @override
  TransactionClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionClass(
      amount: fields[0] as double,
      description: fields[1] as String,
      isCredit: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.isCredit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
