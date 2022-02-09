import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/repository/bloc/data_state.dart';
import 'package:wordie/repository/word_repository.dart';

abstract class DataEvent {}

class StartInitialDataLoad extends DataEvent {}

class DataBloc extends Bloc<DataEvent, DataState> {
  final WordRepository wordRepository;

  DataBloc(
    this.wordRepository,
  ) : super(const DataState(
          isLoading: false,
          loadSucceeded: false,
        )) {
    on<StartInitialDataLoad>(_onStartInitialDataLoad);
  }

  void _onStartInitialDataLoad(
      StartInitialDataLoad event, Emitter<DataState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      loadSucceeded: false,
    ));

    await wordRepository.loadWords();

    emit(state.copyWith(
      isLoading: false,
      loadSucceeded: true,
    ));
  }
}
