import 'dart:convert';
import 'dart:developer';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  ///Gets the cached [List<PersonModel>] which was gotten the last time
  ///the user had internet connection
  ///
  ///Throws [CacheException] if not cached data is present
  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;
  const PersonLocalDataSourceImpl({required this.sharedPreferences});

  static const cacheKey = 'CACHED_PERSONS_LIST';
  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(cacheKey);
    if (jsonPersonsList?.isNotEmpty ?? false) {
      return Future.value(jsonPersonsList!
          .map((e) => PersonModel.fromJSON(json.decode(e)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList =
        persons.map((e) => json.encode(e.toJSON())).toList();
    await sharedPreferences.setStringList(cacheKey, jsonPersonsList);
    log('Persones written in cache');
  }
}
