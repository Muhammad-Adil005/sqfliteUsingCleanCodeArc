import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../Business_layer/entites/user_data.dart';

class LocalDataSource {
  //This line declares a static instance variable named instance of type DatabaseHelper, ensuring that only one instance of DatabaseHelper can exist.
  static final LocalDataSource instance = LocalDataSource();
  static Database? _database;

  //Future<Database> get database async { ... }: This line defines a getter method database that returns a future Database. It initializes and returns the SQLite database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Future<Database> _initDatabase() async { ... }: This line defines a private asynchronous method _initDatabase that creates and initializes the SQLite database.
  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'user_database.db');

    return await openDatabase(databasePath,
        version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        gender TEXT,
        city TEXT,
        address TEXT
      )
    ''');
  }

  Future<int> insertUserData(UserData userData) async {
    final db = await instance.database;
    return await db.insert('user_data', userData.toMap());
  }

  // This function is for updating the data. when user clicked on Edit icon and update the data then this function is get called
  Future<void> updateUserData(UserData userData) async {
    try {
      print('Updating user data: $userData');
      print('User ID: ${userData.id}');
      print('User Name: ${userData.name}');
      if (userData.id == null) {
        print('Error: User ID is null');
        throw Exception('User ID is null');
      }

      final db = await database;
      await db.update(
        'user_data',
        userData.toMap(),
        where: 'id = ?',
        whereArgs: [userData.id],
      );

      // Fetch the updated user data from the database
      //final updatedUserData = await getUserDataById(userData.id!);

      // print('User data updated successfully');
      // print('Updating user data after update: $updatedUserData');
      // print('User ID after update: ${updatedUserData.id}');
      // print('User Name after update: ${updatedUserData.name}');

      //return updatedUserData; // Return the updated userData
    } catch (error) {
      print('Error updating user data: $error');
      rethrow; // Rethrow the error
    }
  }

  //This function is for deleting the Data
  Future<void> deleteUserData(int id) async {
    final db = await instance.database;
    await db.delete(
      'user_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Future<List<UserData>> getUserData() async { ... }: This line defines a method getUserData that retrieves user data from the SQLite database and returns it as a list of UserData objects.
  Future<List<UserData>> getUserData() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('user_data');
    if (maps.isEmpty) {
      return []; // Return an empty list if no data is available
    } else {
      return List.generate(maps.length, (i) {
        return UserData(
          id: maps[i]['id'], // Ensure to provide a valid ID from the database
          name: maps[i]['name'],
          age: maps[i]['age'],
          gender: maps[i]['gender'],
          city: maps[i]['city'],
          address: maps[i]['address'],
        );
      });
    }
  }
}
