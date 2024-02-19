part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

// load tasks
class LoadTasks extends TaskEvent{}

// add task
class AddTask extends TaskEvent{

  final Task task;

  AddTask(this.task);

}
