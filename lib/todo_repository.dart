import 'todo.dart';

class TodoRepository {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  void add(Todo todo) {
    _todoList.add(todo);
  }

  void remove(Todo todo) {
    _todoList.remove(todo);
  }

  void updateTodo(Todo todo) {
    final index = _todoList.indexWhere(
        (element) => element.title.toLowerCase() == todo.title.toLowerCase());
    if (index != -1) {
      _todoList[index] = todo;
    }
  }
}
