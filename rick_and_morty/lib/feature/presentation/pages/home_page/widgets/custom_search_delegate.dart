import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/pages/home_page/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for charachters...');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: "Back",
      onPressed: (() {
        close(context, null);
      }),
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    log('Inside buildResults $query');
    context.read<PersonSearchBloc>().add(SearchPersons(personQuery: query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        } else if (state is PersonSearchLoaded) {
          final persons = state.persons;
          return ListView.builder(
            itemBuilder: ((context, index) {
              PersonEntity result = persons[index];
              return SearchResult(personResult: result);
            }),
            itemCount: persons.isNotEmpty ? state.persons.length : 0,
          );
        } else if (state is PersonSearchError) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Icon(Icons.now_wallpaper));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: ((context, index) => Text(
            _suggestions[index],
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          )),
      separatorBuilder: ((context, index) => const Divider()),
      itemCount: _suggestions.length,
    );
  }
}
