import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:writing_test/model/Person.dart';

class MockPerson extends Mock implements Person {}

void main() {
  group('Person Test', () {
    late Person person;

    setUp(() {
      person = MockPerson();
    });

    test('Constructor should initialize fields correctly', () {
      // Arrange
      when(() => person.name).thenReturn('John');
      when(() => person.age).thenReturn(30);

      // Assert
      expect(person.name, 'John');
      expect(person.age, 30);
    });
  });
}
