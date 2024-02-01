import 'package:flutter/material.dart';
import 'package:writing_test/data/student.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var studentList = students.map((e) => e);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Veriler"),
      ),
      body: ListView(
          children: [
            for(var student in studentList)
              Card(
                shape: const RoundedRectangleBorder(),
                child: ListTile(
                  focusColor: Colors.blueAccent,
                  enabled: true,
                  title: Text(student.toString()),
                  subtitle: Text(student.username()),
                ),
              ),
          ]
        )
    );
  }
}

