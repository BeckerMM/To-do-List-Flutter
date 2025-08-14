import 'package:to_do_list/src/models/Enum/enum_task.dart';

class Task {
  late String title;
  late String? description;
  late Enum status;

  Task({required this.title, this.description, this.status = EnumTask.todo});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status.toString(),
    };
  }

  factory Task.toMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      status: EnumTask.values.firstWhere((e) => e.toString() == map['status']),
    );
  } 
}
