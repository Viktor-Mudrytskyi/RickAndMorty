import 'dart:convert';
import 'dart:developer';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  ///Calls the https://rickandmortyapi.com/api/character/?page=1
  ///Throws [ServerException] for all error codes
  Future<List<PersonModel>> getAllPersons(int page);

  ///Calls the https://rickandmortyapi.com/api/character/?name=rick
  ///Throws [ServerException] for all error codes
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    log(url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons['results'] as List)
          .map((e) => PersonModel.fromJSON(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
