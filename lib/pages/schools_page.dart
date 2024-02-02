import 'package:flutter/material.dart';

class SchoolsPage extends StatefulWidget {
  const SchoolsPage({super.key});

  @override
  State<SchoolsPage> createState() => _SchoolsPageState();
}

class _SchoolsPageState extends State<SchoolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key("school_page_back"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Okullar"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      )
    );
  }
}