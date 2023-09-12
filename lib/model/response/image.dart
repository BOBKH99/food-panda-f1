// To parse this JSON data, do
//
//     final imageResponse = imageResponseFromJson(jsonString);

import 'dart:convert';

List<ImageResponse> imageResponseFromJson(String str) => List<ImageResponse>.from(json.decode(str).map((x) => ImageResponse.fromJson(x)));

String imageResponseToJson(List<ImageResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageResponse {
  int? id;
  String? name;
  dynamic alternativeText;
  dynamic caption;
  int? width;
  int? height;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;

  ImageResponse({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
    id: json["id"],
    name: json["name"],
    alternativeText: json["alternativeText"],
    caption: json["caption"],
    width: json["width"],
    height: json["height"],
    hash: json["hash"],
    ext: json["ext"],
    mime: json["mime"],
    size: json["size"]?.toDouble(),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
  };
}
