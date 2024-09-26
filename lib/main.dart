import 'package:flutter/material.dart';
import 'package:number_rule_app/grid_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.red[100],
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 53, 137, 206),
            title: const Text(
              "Number Grid App",
              style: TextStyle(color: Color.fromARGB(255, 238, 232, 232)),
            ),
          ),
          body: GridScreen(),
        ));
  }
}
