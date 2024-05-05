import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';

import 'todo_add_screen.dart';
import 'todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Center(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoListState) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todoItem = state.todos[index];
                  return TodoTile(
                    todoItem: todoItem,
                    onDeletePressed: () => BlocProvider.of<TodoBloc>(context)
                        .add(TodoEventRemoved(state.todos[index])),
                  );
                },
              );
            } else if (state is TodoInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.pending,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Add your first todo!!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'show_all',
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(TodoShowAllEvents());
            },
            label: const Text('All'),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: 'show_incomplete',
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(TodoNotCompletedEvents());
            },
            label: const Text('Not Done'),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: 'show',
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(TodoCompletedEvents());
            },
            label: const Text('Done'),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TodoDetail();
              }));
            },
            child: const Row(
              children: [Icon(Icons.add), Text('Add')],
            ),
          ),
        ],
      ),
    );
  }
}
