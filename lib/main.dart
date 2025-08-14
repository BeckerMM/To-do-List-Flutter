import 'package:flutter/material.dart';
import 'package:to_do_list/src/models/Enum/enum_task.dart';
import 'package:to_do_list/src/models/task.dart';
import 'package:to_do_list/src/pages/create_task.dart';
import 'package:to_do_list/src/widgets/list_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'To-do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [
    Task(title: 'Task 1', description: 'Description 1', status: EnumTask.doing),
    Task(title: 'Task 2', description: 'Description 2', status: EnumTask.todo),
    Task(title: 'Task 3', description: 'Description 3', status: EnumTask.done),
  ];

  void onDelete(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void onUpdate(Task task) {
    setState(() {
      if (task.status == EnumTask.done) {
        task.status = EnumTask.todo;
      } else {
        task.status = EnumTask.done;
      }
    });
  }

  void onDragCompleted(Task task, EnumTask newStatus) {
    setState(() {
      task.status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Botão Criar Tarefa
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateTaskPage(
                      onCreate: (task) {
                        setState(() {
                          tasks.add(task);
                        });
                      },
                      tasks: tasks,
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Create Task', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Done
            SizedBox(
              height: 250,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                color: Color.fromARGB(158, 164, 255, 161),
                child: ListTask(
                  tasks: tasks.where((t) => t.status == EnumTask.done).toList(),
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                  onDragCompleted: onDragCompleted,
                  status: EnumTask.done,
                  title: 'Done',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Todo
            SizedBox(
              height: 250,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                color: Color.fromARGB(179, 252, 255, 87),
                child: ListTask(
                  tasks: tasks
                      .where((t) => t.status == EnumTask.doing)
                      .toList(),
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                  onDragCompleted: onDragCompleted,
                  status: EnumTask.doing,
                  title: 'Doing',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Doing
            SizedBox(
              height: 250,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                color: Color.fromARGB(179, 217, 238, 238),
                child: ListTask(
                  tasks: tasks.where((t) => t.status == EnumTask.todo).toList(),
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                  onDragCompleted: onDragCompleted,
                  status: EnumTask.todo,
                  title: 'To-Do',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
