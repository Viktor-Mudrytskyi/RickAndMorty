import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonState>{
  final GetAllPersons getAllPersons;
  int page=1;
  PersonListCubit({required this.getAllPersons}):super(PersonEmpty());
  void loadPerson()async{
    if(state is PersonLoading){
      return;
    }
    var oldPersons=<PersonEntity>[];
    if(state is PersonLoaded){
      oldPersons=(state as PersonLoaded).personsList;
    }
    emit(PersonLoading(oldPersonsList: oldPersons,isFirstFetched: page==1));
    final failureOrPErson=await getAllPersons.call(PagePersonParams(page: page));
    failureOrPErson.fold((error) => emit(PersonError(message: _failType(error))), (person) {
      page++;
      final persons=(state as PersonLoading).oldPersonsList;
      persons.addAll(person);
      emit(PersonLoaded(personsList: persons));
    });
  }
  String _failType(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'ServerFailure';
      case CacheFailure:
        return 'CacheFailure';
      default:
        return 'Unexpected Error';
    }
  }
}