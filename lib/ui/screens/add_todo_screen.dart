import 'package:flutter/material.dart';
import 'package:todoapp/utils/local_storage.dart';
import 'package:todoapp/utils/utils.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            'Add Todo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/ss.jpg",
                height: 150,
                width: 220,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Please Add Your Task Here",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onPressAddTodo(
                    context, titleController, descriptionController),
                child: const Text(
                  'Add Todo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )
            ]),
      ),
    );
  }

  void onPressAddTodo(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController descriptionController) {
    // Check Validation for todos form
    if (checkValidation(titleController, descriptionController)) return;

    final todo = Todo(
        title: titleController.text,
        description: descriptionController.text,
        color: randomInteger);

    final todoList = MobileStorage.todoStorage ?? [];
    todoList.insert(0, todo);
    MobileStorage.addTodoStorage(todoList);
    Navigator.pop(context, todo);
  }

  bool checkValidation(TextEditingController titleController,
      TextEditingController descriptionController) {
    if (titleController.text.isEmpty) {
      showToast('Title cannot be empty!');
      return true;
    }
    if (descriptionController.text.isEmpty) {
      showToast('Description cannot be empty!');
      return true;
    }
    return false;
  }
}
