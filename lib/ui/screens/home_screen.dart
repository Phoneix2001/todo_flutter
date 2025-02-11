import 'package:flutter/material.dart';
import 'package:todoapp/utils/local_storage.dart';
import 'package:todoapp/utils/utils.dart';
import '../models/todo.dart';
import 'add_todo_screen.dart';
import '../widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Todo> _todos = [];
  @override
  void initState() {
    super.initState();
    _todos = MobileStorage.todoStorage ?? [];
  }

  void _addTodo(Todo todo) {
    setState(() {
      _todos.insert(0, todo);
    });
    showToast('Todo added!');
  }

  void _toggleCompletion(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
    MobileStorage.addTodoStorage(_todos);
  }

  void _deleteTodoItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Todo'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _todos.removeAt(index);
              });
              MobileStorage.addTodoStorage(_todos);
              Navigator.of(context).pop();
              showToast('Todo deleted!');
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: _todos.isEmpty
          ? Center(
              child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/ss.jpg",
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    ' By completing your tasks, unlock your potential and achieve success.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return TodoCard(
                  todo: _todos[index],
                  onToggle: () => _toggleCompletion(index),
                  onDelete: () => _deleteTodoItem(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          ).then((todo) => _addTodo(todo));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
