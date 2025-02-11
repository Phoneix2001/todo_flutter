import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/utils/local_storage.dart';
import 'package:todoapp/utils/utils.dart';
import 'ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Hive
  await hiveInitialization();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      scaffoldMessengerKey: snackBarKey,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const HomeScreen(),
    );
  }
}

Future<void> hiveInitialization() async {
  final appDocsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocsDir.path);
  await Hive.openBox(MobileStorage.box);
}
