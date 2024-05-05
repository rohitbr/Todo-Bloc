part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class TodoEventAdded extends TodoEvent {
  // accept a todo from the user to be added
  final Todo todo;

  TodoEventAdded(this.todo);
}

final class TodoEventRemoved extends TodoEvent {
  // accept a todo to be removed from the user
  final Todo todo;

  TodoEventRemoved(this.todo);
}

final class TodoEventUpdated extends TodoEvent {
  // accept a todo to be updated from the user
  final Todo todo;

  TodoEventUpdated(this.todo);
}

final class TodoCompletedEvents extends TodoEvent {}

final class TodoNotCompletedEvents extends TodoEvent {}

final class TodoShowAllEvents extends TodoEvent {}
