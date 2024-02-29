// ignore_for_file: file_names

class School {
  late String _name;
  String type = "Üniversite";
  late String _address;
  late int _studentCount;
  static List<String> degrees = [
    "Ön Lisans",
    "Lisans",
    "Yüksek Lisans",
    "Doktora"
  ];
  static List<String> periods = ["Güz Dönemi", "Bahar Dönemi"];

  School() : _studentCount = 1;

  School.withName(String name) {
    setName(name);
    _address = "---";
    _studentCount = 1;
  }

  School.full(String name, String address, int studentCount) {
    setName(name);
    setAddress(address);
    setStudentCount(studentCount);
  }

  String get name => _name;

  set name(String name) {
    setName(name);
  }

  String get address => _address;

  set address(String address) {
    setAddress(address);
  }

  int get studentCount => _studentCount;

  set studentCount(int studentCount) {
    setStudentCount(studentCount);
  }

  void setName(String name) {
    if (name.length >= 2) {
      _name = name;
    } else {
      throw ArgumentError('Okul adı en az 2 karakter olmalıdır.');
    }
  }

  void setAddress(String address) {
    if (address.length >= 3) {
      _address = address;
    } else {
      throw ArgumentError('Adres en az 3 karakter olmalıdır.');
    }
  }

  void setStudentCount(int studentCount) {
    if (studentCount > 0) {
      _studentCount = studentCount;
    } else {
      throw ArgumentError('Geçersiz öğrenci sayısı.');
    }
  }

  String get schoolInfo => "$name, $type, $address, $studentCount";
  
}

