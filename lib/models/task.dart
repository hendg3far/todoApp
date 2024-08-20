class Task {
  static const String collectionName = 'tasks';
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  Task.fromJson(Map<String, dynamic> data):this(
    id: data['id'] as String,
    title: data['title'] as String,
    description: data['description'] as String,
    date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    isDone: data['isDone'] as bool
  );

  Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'isDone': isDone
    };
}
