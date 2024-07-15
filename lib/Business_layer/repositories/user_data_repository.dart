import '../entites/user_data.dart';

abstract class UserDataRepository {
  Future<List<UserData>> getUserData();
  Future<void> insertUserData(UserData userData);
  Future<void> updateUserData(UserData userData);
  Future<void> deleteUserData(int id);
}
