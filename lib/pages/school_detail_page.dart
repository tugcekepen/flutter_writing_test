import 'package:flutter/material.dart';
import 'package:writing_test/model/School.dart';

class SchoolDetailPage extends StatefulWidget {
  final School school;
  
  const SchoolDetailPage({super.key, required this.school});

  @override
  State<SchoolDetailPage> createState() => _SchoolDetailPage();
}

class _SchoolDetailPage extends State<SchoolDetailPage> {
  @override
  Widget build(BuildContext context) {
    final schoolName =  widget.school.name;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key("school_detail_page_back"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Okul Detayı"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Text(schoolName, style: TextStyle(
              fontSize: schoolName.length > 25 ? 25 : 30
            )),
          ),
          const Divider(),
          Text("Adres : ${widget.school.adress}",
          textAlign: TextAlign.left,),
          Text("Okul türü : ${widget.school.grade}"),
          Text("Öğrenci sayısı : ${widget.school.studentCount}"),
        ],
      ),
    );
  }
}