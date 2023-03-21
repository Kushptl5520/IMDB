// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedMovieAdapter extends TypeAdapter<LikedMovie> {
  @override
  final int typeId = 1;

  @override
  LikedMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedMovie(
      id: fields[0] as dynamic,
      title: fields[1] as dynamic,
      posterPath: fields[2] as dynamic,
      original_language: fields[4] as dynamic,
      vote_count: fields[6] as dynamic,
      release_date: fields[3] as dynamic,
      vote_average: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, LikedMovie obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.release_date)
      ..writeByte(4)
      ..write(obj.original_language)
      ..writeByte(5)
      ..write(obj.vote_average)
      ..writeByte(6)
      ..write(obj.vote_count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
