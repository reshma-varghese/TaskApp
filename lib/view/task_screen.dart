import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_sqlite_app/bloc/task_bloc.dart';
import 'package:task_sqlite_app/view/add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  final Future<Database> dataBase;
   const TaskScreen({super.key,required this.dataBase});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(LoadTasks());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tasks')),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if(state is TaskLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Column(
                  children: [
                    ListTile(
                      leading:  Container(
                        width: 80,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Icon(Icons.person),
                              Text("${task.employee}")
                            ]),
                      ),
                      title: Text("Task: ${task.title}"),
                      subtitle: Text("${task.description}"),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                );
              },
            );
          }else if(state is TaskError){
            return Center(
              child: Text("${state.message}"),
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
