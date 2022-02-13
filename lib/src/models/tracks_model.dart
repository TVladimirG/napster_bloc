import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tracks_model.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 0)
@JsonSerializable()
class Track extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String artistId;
  @HiveField(3)
  final String artistName;
  @HiveField(4)
  final String albumName;
  @HiveField(5)
  final String albumId;
  @HiveField(6)
  final String previewURL;
  @HiveField(7)
  DateTime? addedCollection;
  @JsonKey(ignore: true)
  Image? imagePreview;
  @HiveField(8)
  @JsonKey(defaultValue: '')
  String imageAlbumURL = '';

  Track(this.id, this.name, this.artistId, this.artistName, this.albumName,
      this.albumId, this.previewURL, this.addedCollection, this.imageAlbumURL);

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
