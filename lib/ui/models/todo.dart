class Todo {
  final String title;
  final String description;
  bool isCompleted;
  final int color;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.color,
  });

  // Convert todos object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'color': color,
    };
  }

  // Convert JSON map to Todos object
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      color: json['color'] as int,
    );
  }
}
