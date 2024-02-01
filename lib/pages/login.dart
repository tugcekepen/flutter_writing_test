import 'package:flutter/material.dart';
import 'package:writing_test/data/student.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
   final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
          controller: _scrollController,
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: "username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    validator: ((value) {
                      bool isTrue = students.any((student) => student.username() == value);
                      if(value == null || value.isEmpty){
                        return "Username cannot be left blank.";
                      } else if(!isTrue){
                        return "Wrong username";
                      }
                      print(isTrue);
                      print(value);
                      return null;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        hintText: "password",
                        counterText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)))),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,
                    maxLength: 8,
                    validator: ((value) {
                      if(value == null || value.isEmpty){
                        return "Password cannot be left blank.";
                      } else if(value != "12345678"){
                        return "Wrong password";
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
                          builder: (context) => const HomePage(),
                        ),
                      );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Hata'),
                              content: const Text('Zorunlu alanları doldurun.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tamam'),
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
      ),
    );
  }
}
