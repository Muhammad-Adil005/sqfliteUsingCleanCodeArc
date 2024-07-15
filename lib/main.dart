import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_using_clen_code_arc/presentation_layer/pages/add_screen.dart';
import 'package:sqflite_using_clen_code_arc/presentation_layer/pages/edit_screen.dart';
import 'package:sqflite_using_clen_code_arc/presentation_layer/pages/home_screen.dart';
import 'package:sqflite_using_clen_code_arc/presentation_layer/providers/user_provider.dart';

import 'data_layer/data_sources/local_data_source.dart';
import 'data_layer/repositories/user_data_repositories_implementation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          UserProvider(UserDataRepositoryImpl(LocalDataSource.instance)),
      // Pass the required constructor argument
      child: const CleanCodeUsingSQFLITEApp(),
    ),
  );
}

class CleanCodeUsingSQFLITEApp extends StatelessWidget {
  const CleanCodeUsingSQFLITEApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Code Using SQFLITE App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) =>
            const HomeScreen(), // Set HomeScreen as the initial route
        '/add': (context) => const AddScreen(), // Add route for AddScreen
        '/edit': (context) => const EditScreen(), // Add route for EditScreen
      },
    );
  }
}
