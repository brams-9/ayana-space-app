import 'package:json_annotation/json_annotation.dart';

part 'launches_responses.g.dart';

@JsonSerializable(explicitToJson: true)
class LaunchesResponses {
  final String? id;
  final String? name;
  final String? details;
  @JsonKey(name: "date_utc")
  final String? dateUtc;
  @JsonKey(name: "flight_number")
  final int? flightNumber;
  final LinksResponse? links;

  LaunchesResponses({
    this.id,
    this.name,
    this.details,
    this.dateUtc,
    this.links,
    this.flightNumber,
  });

  factory LaunchesResponses.fromJson(Map<String, dynamic> json) =>
      _$LaunchesResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$LaunchesResponsesToJson(this);
}

@JsonSerializable()
class LinksResponse {
  final PatchResponse? patch;
  final String? webcast;
  final String? article;
  final String? wikipedia;

  LinksResponse({
    this.patch,
    this.webcast,
    this.article,
    this.wikipedia,
  });

  factory LinksResponse.fromJson(Map<String, dynamic> json) =>
      _$LinksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LinksResponseToJson(this);
}

@JsonSerializable()
class PatchResponse {
  final String? small;
  final String? large;

  PatchResponse({this.small, this.large});

  factory PatchResponse.fromJson(Map<String, dynamic> json) =>
      _$PatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PatchResponseToJson(this);
}
