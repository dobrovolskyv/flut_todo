import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext content) {
      return Scaffold(
          appBar: AppBar(title: const Text('menu')),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text('back to main'),
              ),
              const Padding(padding: EdgeInsets.only(left: 15)),
              const Text('New menu'),
            ],
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('List to do'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: menuOpen, icon: const Icon(Icons.menu))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('No lists');
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get('item')),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance
                        .collection('items')
                        .doc(snapshot.data?.docs[index].id)
                        .delete();
                  },
                );
              });
        },
      ),
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
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'item': userToDo});

                          Navigator.of(context).pop();
                        },
                        child: const Text('Added'))
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
