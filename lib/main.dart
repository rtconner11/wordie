import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wordie/game/bloc/game_bloc.dart';
import 'package:wordie/game/game_window.dart';
import 'package:wordie/repository/bloc/data_bloc.dart';
import 'package:wordie/repository/bloc/data_state.dart';
import 'package:wordie/repository/word_repository.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const Root());
}

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
              return const App();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Wordie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) =>
              GameBloc(context.read<WordRepository>())..add(NewGameRequested()),
          child: const GameWindow(),
        ),
      ),
    );
  }
}
