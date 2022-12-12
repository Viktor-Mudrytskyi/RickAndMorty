import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/pages/home_page/widgets/person_cached_image.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detailed_page/person_detailed_page.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.personResult});
  final PersonEntity personResult;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => DetailPage(person: personResult)))),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonCachedImage(
              height: 300,
              url: personResult.image,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                personResult.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                personResult.origin.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
