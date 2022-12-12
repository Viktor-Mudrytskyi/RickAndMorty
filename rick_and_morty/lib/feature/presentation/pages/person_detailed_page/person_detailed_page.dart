import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/home_page/widgets/person_cached_image.dart';

class DetailPage extends StatelessWidget {
  final PersonEntity person;
  const DetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final whiteStyle = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17);
    final greyStyle = Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charachter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                person.name,
                style: whiteStyle.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: PersonCachedImage(
                  url: person.image,
                  width: 230,
                  height: 230,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                      color:
                          (person.status == 'Alive') ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '${person.status} ',
                    style: whiteStyle,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Gender:',
                style: greyStyle,
              ),
              Text(
                person.gender,
                style: whiteStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Number of episodes: ',
                style: greyStyle,
              ),
              Text(
                '${person.episode.length}',
                style: whiteStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Species: ',
                style: greyStyle,
              ),
              Text(
                person.species,
                style: whiteStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Last known location: ',
                style: greyStyle,
              ),
              Text(
                person.location.name,
                style: whiteStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Origin: ',
                style: greyStyle,
              ),
              Text(
                person.origin.name,
                style: whiteStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Was created: ',
                style: greyStyle,
              ),
              Text(
                person.created.toIso8601String().substring(0, 10),
                style: whiteStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
