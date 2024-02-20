import 'package:flutter/material.dart';
import 'package:writing_test/pages/school_detail_page.dart';
import '../data/school.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              for (var school in schools)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: MenuItemButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SchoolDetailPage(school: school)));
                        },
                        style: MenuItemButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              width: 2),
                        ),
                        child: Text(school.name),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
            ],
          ),
        ));
  }
}
