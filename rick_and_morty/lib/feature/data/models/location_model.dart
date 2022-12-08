import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required String name,
    required String url,
  }) : super(
          name: name,
          url: url,
        );
  factory LocationModel.fromJSON(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
