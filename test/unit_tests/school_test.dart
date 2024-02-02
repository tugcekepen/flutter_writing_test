import 'package:flutter_test/flutter_test.dart';
import 'package:writing_test/model/School.dart';

void main(){
  group("tests to school methods", () {
    test("School.withName constructor", () {
      //Arrange
      final school = School.withName("Samsun Üniversitesi");

      //Act
      String name = school.name;

      //Assert
      expect(name, "Samsun Üniversitesi");
      expect(name, isNotNull);
    });

    test("schoolInfo()", () {
      //Arrange
      final school = School.withName("Samsun Üniversitesi");
      school.grade = "Üniversite";
      school.adress = "Samsun";
      school.studentCount = 10000;

      //Act
      String info = school.schoolInfo();

      //Assert
      expect(info, "Okul: Samsun Üniversitesi Türü: Üniversite Adresi: Samsun Öğrenci Sayısı: 10000");
      expect(school.periods, ["Güz Dönemi", "Bahar Dönemi"]);
    });
  });
}