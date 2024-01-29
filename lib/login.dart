import 'package:flutter/material.dart';
import 'package:writing_test/main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Form(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200, bottom: 30),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200, bottom: 30),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                        title: "My Flutter Project",
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                ),
                child: const Text("Giriş Yap")),
          ]),
        ),
      ),
    );
  }
}
