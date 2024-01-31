class Student {
  late String _firstName;
  late String _lastName;

  Student(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    if(_firstName.length >= 2) {
      _firstName = value;
    } else {
      throw ArgumentError('First name must be at least 2 characters long.');
    }
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if(_lastName.length >= 2) {
      _lastName = value;
    } else {
      throw ArgumentError('Last name must be at least 2 characters long.');
    }
  }

  @override
  String toString(){
    return "$firstName $lastName";
  }

  String username(){
    return "$firstName$lastName".toLowerCase().replaceAll('ı', 'i').replaceAll('ğ', 'g').replaceAll('ş', 's').replaceAll('ç', 'c').replaceAll('ü', 'u').replaceAll('ö', 'o');
  }
}