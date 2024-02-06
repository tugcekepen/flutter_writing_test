import 'package:flutter/material.dart';
import 'package:writing_test/pages/schools_page.dart';
import 'package:writing_test/pages/students_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key("home_page_back"),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ana Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.exposure_plus_1)),
                ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.exposure_minus_1))
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentsListPage(),
                    ),
                  );
                },
                child: const Text("Öğenciler")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SchoolsPage(),
                    ),
                  );
                },
                child: const Text("Okullar")),
          ],
        ),
      ),
    );
  }
}
