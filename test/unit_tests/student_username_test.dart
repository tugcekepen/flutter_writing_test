import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/Student.dart';

void main(){
  test("username method should return the user name of the student", () {
    final student = Student("Tuğçe", "Kepen");

    String username = student.username();

    expect(username, "tugcekepen");
  });
}