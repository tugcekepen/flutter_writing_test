import 'package:flutter/material.dart';
import 'package:writing_test/main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                validator: ((value) {
                  if(value == null || value.isEmpty){
                    return "Username cannot be left blank.";
                  }
                  return null;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                validator: ((value) {
                  if(value == null || value.isEmpty){
                    return "Password cannot be left blank.";
                  }
                  return null;
                }),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: Text('Zorunlu alanları doldurun.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  
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
