// lib/data/models/user_data_model.dart

class UserDataModel {
  final int? id;
  final String name;
  final int age;
  final String gender;
  final String city;
  final String address;

  UserDataModel({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    required this.address,
  });
  // : super(
  //       name: name,
  //       age: age,
  //       gender: gender,
  //       city: city,
  //       address: address,
  //     );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'city': city,
      'address': address,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      city: map['city'],
      address: map['address'],
    );
  }
}
