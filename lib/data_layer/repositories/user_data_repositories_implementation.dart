// lib/data/repositories/user_data_repository.dart
import '../../Business_layer/entites/user_data.dart';
import '../../Business_layer/repositories/user_data_repository.dart';
import '../data_sources/local_data_source.dart';

class UserDataRepositoryImpl implements UserDataRepository {
  final LocalDataSource localDataSource;

  UserDataRepositoryImpl(this.localDataSource);

  Future<List<UserData>> getUserData() async {
    // Implement logic to get user data from local data source
    return await localDataSource.getUserData();
  }

  Future<void> insertUserData(UserData userData) async {
    // Implement logic to insert user data into local data source
    await localDataSource.insertUserData(userData);
  }

  Future<void> updateUserData(UserData userData) async {
    // Implement logic to update user data in local data source
    await localDataSource.updateUserData(userData);
  }

  Future<void> deleteUserData(int id) async {
    // Implement logic to delete user data from local data source
    await localDataSource.deleteUserData(id);
  }
}
