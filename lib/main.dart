import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/game/game_window.dart';
import 'package:wordie/repository/bloc/data_bloc.dart';
import 'package:wordie/repository/bloc/data_state.dart';
import 'package:wordie/repository/word_repository.dart';

void main() => runApp(const Root());

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WordRepository(),
      child: BlocProvider<DataBloc>(
        create: (context) {
          return DataBloc(context.read<WordRepository>())
            ..add(StartInitialDataLoad());
        },
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Container(
                color: Colors.blue,
              );
            } else if (state.loadSucceeded) {
              return const GameWindow();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
