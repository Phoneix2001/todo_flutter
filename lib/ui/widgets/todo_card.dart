import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  // Constructor to initialize required values
  const TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightColors[todo.color]
          .withAlpha(100), // Apply a slightly transparent random color
      margin: const EdgeInsets.all(8.0),
      // elevation: 4, // Adds a subtle shadow for better UI
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Soft rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 18, // Slightly bigger for readability
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              todo.description,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggle(),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(6), // Slightly rounded checkbox
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
            tooltip: 'Delete Task', // Shows tooltip on long press
          ),
        ),
      ),
    );
  }
}
