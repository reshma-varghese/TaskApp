import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sqlite_app/bloc/task_bloc.dart';
import 'package:task_sqlite_app/model/Task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedEmployee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Task Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Task Description'),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: DropdownButtonFormField<String>(
                          hint: Text("Select Employee"),
                          items: <String>['Employee A', 'Employee B', 'Employee C', 'Employee D'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Employee is required';
                            }
                          },
                          value: _selectedEmployee,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedEmployee = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        fixedSize: const Size(150, 50),
                        elevation: 2,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final task = Task(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              employee: _selectedEmployee.toString()
                          );
                          context.read<TaskBloc>().add(AddTask(task));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit',
                          style: TextStyle(
                              fontSize: 17,
                          color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
}
