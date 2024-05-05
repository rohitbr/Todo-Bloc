part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoListState extends TodoState {
  // emit the list of todos as a state
  final List<Todo> todos;

  TodoListState(this.todos);
}
