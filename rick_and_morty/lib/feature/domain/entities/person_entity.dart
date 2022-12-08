import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime created;
  const PersonEntity({
    required this.created,
    required this.episode,
    required this.gender,
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    required this.origin,
    required this.species,
    required this.status,
    required this.type,
  });

  @override
  List<Object?> get props => [
        created,
        episode,
        gender,
        id,
        image,
        location,
        name,
        origin,
        species,
        status,
        type,
      ];
}

class LocationEntity {
  final String name;
  final String url;
  const LocationEntity({
    required this.name,
    required this.url,
  });
}
