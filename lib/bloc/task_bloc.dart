import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_sqlite_app/model/Task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  final Future<Database> database;
  final bool isDataBaseExists;

  TaskBloc(this.database, this.isDataBaseExists) : super(TaskInitial()) {

    on<AddTask>((event, emit) async {

      emit(TaskLoading());
      try{
        if(!isDataBaseExists){
          emit(TaskError(message: "Database does not exists"));
        }
        await insertTask(event.task);
        final List<Task> tasks = await getTasks();
        emit(TaskLoaded(tasks));

      }catch(e){
        emit(TaskError(message: e.toString()));
      }

    });

    on<LoadTasks>((event, emit)async{

      emit(TaskLoading());
      try{
        if(!isDataBaseExists){
          emit(TaskError(message: "Database does not exists"));
        }

        final List<Task> tasks = await getTasks();
        emit(TaskLoaded(tasks));

      }catch(e){
        emit(TaskError(message: e.toString()));
      }

    });

  }

  Future<List<Task>> getTasks() async{

    final Database db = await database;
    final List<Map<String,dynamic>> maps =await db.query('tasks');
    return List.generate(maps.length,(index){
      return Task.fromMap(maps[index]);
    });
  }

  Future<void> insertTask(Task task) async{
    final Database db =  await database;
    await db.insert('tasks', task.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

}



