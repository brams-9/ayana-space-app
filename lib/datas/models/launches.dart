import 'package:ayana_space_app/cores/utils/formatter/date.dart';
import 'package:ayana_space_app/datas/dto/launches_responses.dart';

class Launches {
  final String? id;
  final String? name;
  final String? details;
  final String? launchDate;
  final String? launchTime;
  final Links? links;
  final int? flightNumber;

  Launches({
    this.id,
    this.name,
    this.details,
    this.launchDate,
    this.launchTime,
    this.links,
    this.flightNumber,
  });

  factory Launches.fromResponses(LaunchesResponses response) {
    final patchResponse = response.links?.patch;
    final webcast = response.links?.webcast;
    final article = response.links?.article;
    final wikipedia = response.links?.wikipedia;

    final patch = Patch(
      small: patchResponse?.small,
      large: patchResponse?.large,
    );

    DateTime launchDateUtc = DateTime.parse(response.dateUtc ?? '');

    return Launches(
      id: response.id,
      name: response.name,
      details: response.details,
      launchDate: DateFormatter.formatDate(launchDateUtc),
      launchTime: DateFormatter.formatTime(launchDateUtc),
      flightNumber: response.flightNumber,
      links: Links(
        patch: patch,
        webcast: webcast,
        article: article,
        wikipedia: wikipedia,
      ),
    );
  }
}

class Links {
  final Patch? patch;
  final String? webcast;
  final String? article;
  final String? wikipedia;

  Links({
    this.patch,
    this.webcast,
    this.article,
    this.wikipedia,
  });
}

class Patch {
  final String? small;
  final String? large;

  Patch({this.small, this.large});
}

enum LaunchType {
  upComing('upcoming'),
  past('past'),
  latest('latest');

  final String value;

  const LaunchType(this.value);
}
