import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo.dart';

class TodoDetail extends StatefulWidget {
  TodoDetail({super.key});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final TextEditingController controller = TextEditingController();
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Add Todo',
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Completed'),
                  autofocus: false,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  selected: _isCompleted,
                  value: _isCompleted,
                  onChanged: (bool? value) {
                    if (mounted) {
                      setState(() {
                        _isCompleted = value!;
                      });
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(
                  TodoEventAdded(
                    Todo(
                      title: controller.text,
                      isDone: _isCompleted,
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
