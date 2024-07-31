import 'package:oohwee/features/characters/views/widgets/character_status.dart';

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Origin location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: CharacterStatusExtension.fromString(json["status"]),
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: Origin.fromJson(json["origin"]),
        location: Origin.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

class Origin {
  String name;
  String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromJson(Map<String?, dynamic> json) =>
      Origin(name: json['name'], url: json['url']);

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
