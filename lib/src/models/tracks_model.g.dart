// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackAdapter extends TypeAdapter<Track> {
  @override
  final int typeId = 0;

  @override
  Track read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Track(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as DateTime?,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Track obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artistId)
      ..writeByte(3)
      ..write(obj.artistName)
      ..writeByte(4)
      ..write(obj.albumName)
      ..writeByte(5)
      ..write(obj.albumId)
      ..writeByte(6)
      ..write(obj.previewURL)
      ..writeByte(7)
      ..write(obj.addedCollection)
      ..writeByte(8)
      ..write(obj.imageAlbumURL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      json['id'] as String,
      json['name'] as String,
      json['artistId'] as String,
      json['artistName'] as String,
      json['albumName'] as String,
      json['albumId'] as String,
      json['previewURL'] as String,
      json['addedCollection'] == null
          ? null
          : DateTime.parse(json['addedCollection'] as String),
      json['imageAlbumURL'] as String? ?? '',
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
      'previewURL': instance.previewURL,
      'addedCollection': instance.addedCollection?.toIso8601String(),
      'imageAlbumURL': instance.imageAlbumURL,
    };
