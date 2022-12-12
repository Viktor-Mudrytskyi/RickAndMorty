import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/pages/home_page/widgets/person_card.dart';

class PersonsList extends StatelessWidget {
  final NetworkInfo networkInfo;
  PersonsList({super.key, required this.networkInfo});
  final scrollCon = ScrollController();
  void setupScrollCon(BuildContext context) {
    scrollCon.addListener(() async {
      if (scrollCon.position.atEdge) {
        if (scrollCon.position.pixels != 0 && await networkInfo.isConnected) {
          log('trigger');
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollCon(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: ((context, state) {
        bool isLoading = false;
        List<PersonEntity> persons = [];
        if (state is PersonLoading && state.isFirstFetched) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        } else if (state is PersonLoading) {
          persons = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        } else if (state is PersonError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          controller: scrollCon,
          separatorBuilder: ((context, index) =>
              Divider(color: Colors.grey.shade400)),
          itemCount: persons.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              log('Circular');
              Timer(const Duration(milliseconds: 5), () {
                scrollCon.jumpTo(scrollCon.position.maxScrollExtent);
              });
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
          },
        );
      }),
    );
  }
}
