import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('List to do'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text(
            'main screen',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/todo");
              },
              child: const Text('next'))
        ],
      ),
    );
  }
}
