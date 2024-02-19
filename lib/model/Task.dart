class Task {

  final int? id;
  final String? title;
  final String? description;
  final String? employee;

  Task({this.id,this.title, required this.description, this.employee});

  Map<String, dynamic> toMap() {
    return {'id':id,'title': title, 'description': description, 'employee': employee};
  }

  factory Task.fromMap(Map<String,dynamic>map) {
    return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        employee: map['employee']);
  }
}
