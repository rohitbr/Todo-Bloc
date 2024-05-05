import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_repository.dart';

import 'views/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: TodoRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(context.read<TodoRepository>()),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: Center(
              child: HomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
