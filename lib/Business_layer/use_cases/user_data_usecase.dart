// lib/domain/use_cases/user_data_usecase.dart
import '../entites/user_data.dart';
import '../repositories/user_data_repository.dart';

class UserDataUseCase {
  final UserDataRepository repository;

  UserDataUseCase(this.repository);

  Future<List<UserData>> getUserData() {
    return repository.getUserData();
  }

  Future<void> insertUserData(UserData userData) {
    return repository.insertUserData(userData);
  }

  Future<void> updateUserData(UserData userData) {
    return repository.updateUserData(userData);
  }

  Future<void> deleteUserData(int id) {
    return repository.deleteUserData(id);
  }
}
