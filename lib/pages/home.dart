import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String userToDo;
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['buy milk', 'wash dishes', 'eat meat']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('List to do'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(todoList[index]),
              child: Card(
                child: ListTile(
                  title: Text(todoList[index]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add element'),
                  content: TextField(
                    onChanged: (String value) {
                      userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        todoList.add(userToDo);
                      });

                      Navigator.of(context).pop();
                    }, child: const Text('Added'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),

      ),
    );
  }
}
