import 'package:flutter/material.dart';
import 'package:writing_test/data/student.dart';

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  var studentList = students.map((e) => e);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key("list_page_back"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Öğenciler"),
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
                  subtitle: Text(student.username),
                ),
              ),
          ]
        )
    );
  }
}

