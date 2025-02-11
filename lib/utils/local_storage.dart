import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/ui/models/todo.dart';

class MobileStorage {
  MobileStorage._();
  //User Credentials Box Name
  static const String box = "userCredentials123";

  // App Environment

  static const String _todoStorage = "TODO_STORAGE";

  static List<Todo>? get todoStorage {
    final todoListJson = readData(box, _todoStorage);

    if (todoListJson == null) return null; // Return null if no data found

    final List<dynamic> decodedList = jsonDecode(todoListJson);

    // Convert to List<Todos>
    final List<Todo> todoList = decodedList
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();

    return todoList;
  }

  static addTodoStorage(List<Todo>? todos) {
    final todosJson = jsonEncode(todos?.map((e) => e.toJson()).toList());
    writeData(todosJson, box, _todoStorage);
  }
}

//DataBase Hive Write
void writeData(dynamic data, String box, String key) {
  try {
    final myBox = Hive.box(box);
    myBox.put(key, data);
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
}

//Database Hive Read
dynamic readData(String box, String key) {
  dynamic value;
  Hive.openBox(box);
  try {
    final myBox = Hive.box(box);
    value = myBox.get(key);
    return value;
  } on Exception catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
  return value;
}

//Delete Local Data
bool deleteData(String key, String box) {
  bool value = true;
  try {
    final myBox = Hive.box(box);
    myBox.delete(key);
  } catch (e, s) {
    value = false;
    debugPrint(e.toString());
    debugPrint(s.toString());
  }

  return value;
}

//Delete All Local Data
bool deleteAll(String box) {
  var value = true;
  try {
    final myBox = Hive.box(box);
    myBox.clear();
  } catch (e, s) {
    value = false;
    debugPrint(e.toString());
    debugPrint(s.toString());
  }
  return value;
}
