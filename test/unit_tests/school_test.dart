import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/School.dart';

class MockSchool extends Mock implements School {}

void main() {
  late School mockSchool;
  late School school;
  late School schoolWithName;

  setUp(() {
    mockSchool = MockSchool();
    school = School.full("Samsun Üniversitesi", "Samsun", 50000);
    schoolWithName = School.withName("Samsun Üniversitesi");
  });

  group("School constructors", () {
    test("School.withName constructor", () {
      final school = School.withName("Samsun Üniversitesi");

      expect(school.name, "Samsun Üniversitesi");
    });

    test("School.full constructor", () {
      //Arrange
      final school = School.full("Samsun Üniversitesi", "Samsun", 50000);

      //Act
      String name = school.name;
      String address = school.address;
      int studentCount = school.studentCount;

      //Assert
      expect(name, "Samsun Üniversitesi");
      expect(address, "Samsun");
      expect(studentCount, isPositive);
    });
  });

  group("tests to school methods", () {
    test("schoolInfo - full ctr", () {
      when(() => mockSchool.name).thenReturn("Samsun Üniversitesi");
      when(() => mockSchool.type).thenReturn("Üniversite");
      when(() => mockSchool.address).thenReturn("Samsun");
      when(() => mockSchool.studentCount).thenReturn(1);

      when(() => mockSchool.schoolInfo)
          .thenReturn("Samsun Üniversitesi Üniversite Samsun 1");

      expect(school.schoolInfo, "Samsun Üniversitesi, Üniversite, Samsun, 50000");
    });

    test("schoolInfo - withName ctr", () {
      expect(schoolWithName.schoolInfo, "Samsun Üniversitesi, Üniversite, ---, 1");
    });
  });

  group("Errors in School class", () {
    test("School name cannot be less than 2 characters", () {
      expect(() => school.name = "", throwsA(isArgumentError));
      expect(() => school.name = "A", throwsArgumentError);
    });

    test("School address cannot be less than 3 characters", () {
      expect(() => school.address = "", throwsA(isArgumentError));
      expect(() => school.address = "A", throwsA(isArgumentError));
      expect(() => school.address = "Ab", throwsArgumentError);
    });

    test("Student count in school cannot be less than 1", () {
      expect(() => school.studentCount = 0, throwsA(isArgumentError));
      expect(() => school.studentCount = -1, throwsArgumentError);
    });
  });
}
