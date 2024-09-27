import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all bindings are initialized

  // Initialize Hive
  await Hive.initFlutter();

  // Open the Hive box
  try {
    await Hive.openBox('mybox');
  } catch (e) {
    // Handle potential errors when opening the box
    print("Error opening Hive box: $e");
  }

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App', // Added title for better app identification
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // Adaptive layout across devices
      ),
      home: const HomePage(),
    );
  }
}
