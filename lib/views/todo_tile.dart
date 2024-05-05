import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';

import '../todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.todoItem,
    required this.onDeletePressed,
  });

  final Todo todoItem;

  final VoidCallback? onDeletePressed;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          child: ListTile(
            title: Text(widget.todoItem.title),
            leading: Checkbox(
              autofocus: false,
              activeColor: Colors.green,
              checkColor: Colors.white,
              value: widget.todoItem.isDone,
              onChanged: (bool? value) {
                if (mounted) {
                  BlocProvider.of<TodoBloc>(context)
                      .add(TodoEventUpdated(widget.todoItem));
                }
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: widget.onDeletePressed,
            ),
          ),
        ));
  }
}
