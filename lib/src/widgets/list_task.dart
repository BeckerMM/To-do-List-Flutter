import 'package:flutter/material.dart';
import 'package:to_do_list/src/models/Enum/enum_task.dart';
import 'package:to_do_list/src/models/task.dart';
import 'package:to_do_list/src/widgets/task_card.dart';

class ListTask extends StatelessWidget {
  final List<Task> tasks;
  final String title;
  final Function(Task) onDelete;
  final Function(Task) onUpdate;
  final Function(Task,EnumTask) onDragCompleted;
  final EnumTask status;

  const ListTask({
    super.key,
    required this.tasks,
    required this.onDelete,
    required this.onUpdate,
    required this.onDragCompleted,
    required this.status, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      onAcceptWithDetails: (details) {
        onDragCompleted(details.data, status);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(8.0),
          color: const Color.fromARGB(255, 238, 238, 238),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskCard(
                      task: task,
                      onDelete: onDelete,
                      onUpdate: onUpdate,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
