import 'package:rick_and_morty/feature/data/models/location_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required DateTime created,
    required List<String> episode,
    required String gender,
    required int id,
    required String image,
    required LocationEntity location,
    required String name,
    required LocationEntity origin,
    required String species,
    required String status,
    required String type,
  }) : super(
          created: created,
          episode: episode,
          gender: gender,
          image: image,
          id: id,
          location: location,
          name: name,
          origin: origin,
          species: species,
          status: status,
          type: type,
        );
  factory PersonModel.fromJSON(Map<String, dynamic> json) {
    return PersonModel(
      created: DateTime.parse(json['created'] as String),
      episode: (json['episode'] as List<String>).map((e) => e).toList(),
      gender: json['gender'],
      id: json['id'],
      image: json['image'],
      location: LocationModel.fromJSON(json['location']),
      name: json['name'],
      origin: LocationModel.fromJSON(json['origin']),
      species: json['species'],
      status: json['status'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'created': created,
        'episode': episode,
        'gender': gender,
        'image': image,
        'location': location,
        'origin': origin,
        'species': species,
        'status': status,
        'type': type,
      };
}
