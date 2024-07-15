class UserData {
  final int? id;
  final String name;
  final int age;
  final String gender;
  final String city;
  final String address;

  UserData({
     this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    required this.address,
  });

  // Convert UserData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'city': city,
      'address': address,
    };
  }

  // Create a UserData object from a Map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      city: map['city'],
      address: map['address'],
    );
  }
}
