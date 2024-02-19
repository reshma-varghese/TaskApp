import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_sqlite_app/bloc/task_bloc.dart';
import 'package:task_sqlite_app/view/task_screen.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> dataBase = openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,employee TEXT )',
        );
      },
      version: 1

  );

  bool _dataBaseExists = await databaseExists(
      join(await getDatabasesPath(),'task_database.db')
  );
  runApp(MyApp(dataBase: dataBase, dataBaseExists:_dataBaseExists,));
}

class MyApp extends StatelessWidget {
  final Future<Database> dataBase;
  final bool dataBaseExists;


  MyApp({super.key, required this.dataBase, required this.dataBaseExists});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => TaskBloc(dataBase,dataBaseExists),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskScreen(dataBase: dataBase,),
      ),
    );
  }
}



