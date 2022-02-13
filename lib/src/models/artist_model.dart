import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class Artist {
  final String id;
//  final String type;
  final String name;
  //final String shortcut;
  @JsonKey(name: 'bios', defaultValue: [])
  final List<Map<String, dynamic>> bios;
  @JsonKey(ignore: true)
  Image? imagePreview;
  @JsonKey(defaultValue: '')
  String? imagePreviewURL;
  @JsonKey(ignore: true)
  String biography = '';

  Artist(this.id, this.name, this.bios, this.imagePreviewURL);

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
