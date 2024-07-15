// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../Business_layer/entites/user_data.dart';
import '../../data_layer/repositories/user_data_repositories_implementation.dart';

class UserProvider extends ChangeNotifier {
  final UserDataRepositoryImpl _userRepository;

  UserProvider(this._userRepository);

  final FormGroup form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'age':
        FormControl<int>(validators: [Validators.required, Validators.min(18)]),
    'gender': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'address': FormControl<String>(validators: [Validators.required]),
  });

  final List<String> cities = [
    'Islamabad',
    'Peshawar',
    'Multan',
    'Faisalabad',
    'Karachi'
  ];

  List<UserData> _userList = [];
  List<UserData> get userList => _userList;

  Future<void> fetchUserData() async {
    _userList = await _userRepository.getUserData();
    notifyListeners();
  }

  // This function is for adding a data
  Future<void> addUser() async {
    if (form.valid) {
      final userData = UserData(
        name: form.control('name').value,
        age: form.control('age').value,
        gender: form.control('gender').value,
        city: form.control('city').value,
        address: form.control('address').value,
      );
      await _userRepository.insertUserData(userData);
      await fetchUserData(); // Refresh user list
    }
  }

  // This function is for updating a data
  Future<void> updateUser(UserData userData) async {
    await _userRepository.updateUserData(userData);
    await fetchUserData(); // Refresh user list
  }

  // This function is for deleting a data
  Future<void> deleteUserData(int id) async {
    await _userRepository.deleteUserData(id);
    await fetchUserData(); // Refresh user list
  }

  void resetForm() {
    form.reset();
  }

  void setUserData(UserData userData) {
    form.control('name').value = userData.name;
    form.control('age').value = userData.age;
    form.control('gender').value = userData.gender;
    form.control('city').value = userData.city;
    form.control('address').value = userData.address;
  }
}
