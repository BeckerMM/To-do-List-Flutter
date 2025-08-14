import 'package:flutter/material.dart';
import 'package:to_do_list/src/models/Enum/enum_task.dart';
import 'package:to_do_list/src/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(Task) onDelete;
  final Function(Task) onUpdate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Task>(
      data: task,
      feedback: Material(borderOnForeground: false, 
      borderRadius: BorderRadius.all(Radius.circular(8)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 80,
          child: Card(
            margin: const EdgeInsets.all(0),
            borderOnForeground: false,
            elevation: 4,
            color: const Color.fromARGB(117, 185, 185, 185),
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(task.description ?? ''),
            ),
          ),
        ),
      ),
      child: SizedBox(
        height: 80,
        child: Card(
          child: ListTile(
            leading: Checkbox(
              value: task.status == EnumTask.done,
              onChanged: (_) => onUpdate(task),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.status == EnumTask.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(
              task.description ?? '',
              style: TextStyle(
                color: Colors.grey.shade600,
                decoration: task.status == EnumTask.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(task),
            ),
            onTap: () => onUpdate(task),
          ),
        ),
      ),
    );
  }
}
