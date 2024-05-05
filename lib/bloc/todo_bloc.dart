import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/todo_repository.dart';

import '../todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoInitial()) {
    on<TodoEventAdded>(todoEventAdded);
    on<TodoEventRemoved>(todoEventRemoved);
    on<TodoEventUpdated>(todoEventUpdated);
    on<TodoCompletedEvents>(todoCompletedEvents);
    on<TodoNotCompletedEvents>(todoNotCompletedEvents);
    on<TodoShowAllEvents>(todoShowAllEvents);
  }

  FutureOr<void> todoShowAllEvents(
      TodoShowAllEvents event, Emitter<TodoState> emit) {
    emit(TodoListState(repository.todoList));
  }

  FutureOr<void> todoEventAdded(TodoEventAdded event, Emitter<TodoState> emit) {
    final todo = event.todo;

    repository.add(todo);
    emit(TodoListState(repository.todoList));
  }

  FutureOr<void> todoEventRemoved(
      TodoEventRemoved event, Emitter<TodoState> emit) {
    final todo = event.todo;
    repository.remove(todo);
    if (repository.todoList.isEmpty) {
      emit(TodoInitial());
    } else {
      emit(TodoListState(repository.todoList));
    }
  }

  FutureOr<void> todoEventUpdated(
      TodoEventUpdated event, Emitter<TodoState> emit) {
    final todo = event.todo;
    final changedTodo = todo.copyWith(isDone: !todo.isDone);
    repository.updateTodo(changedTodo);
    emit(TodoListState(repository.todoList));
  }

  FutureOr<void> todoCompletedEvents(
      TodoCompletedEvents event, Emitter<TodoState> emit) {
    final completedTodos =
        repository.todoList.where((todo) => todo.isDone).toList();
    emit(TodoListState(completedTodos));
  }

  FutureOr<void> todoNotCompletedEvents(
      TodoNotCompletedEvents event, Emitter<TodoState> emit) {
    final notCompletedTodos =
        repository.todoList.where((todo) => !todo.isDone).toList();
    emit(TodoListState(notCompletedTodos));
  }
}
