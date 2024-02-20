// ignore_for_file: file_names

class Person {
  late String name;
  late int age;

  Person();

  Person.full(this.name, this.age);

  String getUpperCaseName(String name) => name.toUpperCase();
}
