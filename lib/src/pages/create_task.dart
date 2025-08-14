import 'package:flutter/material.dart';
import 'package:to_do_list/src/models/Enum/enum_task.dart';
import 'package:to_do_list/src/models/task.dart';

class CreateTaskPage extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onCreate;

  const CreateTaskPage({
    super.key,
    required this.tasks,
    required this.onCreate,
  });

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String title = '';
  String description = '';
  EnumTask status = EnumTask.todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.0,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<EnumTask>(
                value: status,
                onChanged: (EnumTask? newValue) {
                  if (newValue != null) {
                    setState(() {
                      status = newValue;
                    });
                  }
                },
                items: EnumTask.values.map((EnumTask status) {
                  return DropdownMenuItem<EnumTask>(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),
                isExpanded: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (title.isNotEmpty) {
                    widget.onCreate(
                      Task(
                        title: title,
                        description: description,
                        status: status,
                      ),
                    );
                  }
                },
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
