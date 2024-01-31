import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Student.dart';

void main(){
  test("toString method should return the full name of the student", () {
    final student = Student("Tuğçe", "Kepen");

    String fullName = student.toString();

    expect(fullName, "Tuğçe Kepen");
  });
}