part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

// loading - will show progressbar
class TaskLoading extends TaskState {}

// loaded - returned tasks
class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);
}

// error state - return error message
class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}
