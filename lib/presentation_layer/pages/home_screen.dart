import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/show_confirmation_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    print('home screen called');
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final userList = userProvider.userList;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Home Screen'),
          ),
          body: userList.isEmpty
              ? const Center(
                  child: Text('No data available'),
                )
              : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    final userData = userList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            userData.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Age: ${userData.age}, City: ${userData.city}, Address: ${userData.address}',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (String choice) {
                              if (choice == 'edit') {
                                Navigator.pushNamed(
                                  context,
                                  '/edit',
                                  arguments: {'userData': userData},
                                );
                              } else if (choice == 'delete') {
                                _showDeleteConfirmationDialog(userData.id!);
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: {'userData': userData},
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).resetForm();
              Navigator.pushNamed(context, '/add');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowConfirmationDialog(
          title: 'Delete Confirmation',
          message: 'Are you sure you want to delete this item?',
          onConfirm: () {
            Navigator.of(context).pop();
            _deleteUserData(id);
          },
        );
      },
    );
  }

  void _deleteUserData(int id) {
    // Implement your logic to delete user data from local DB
    // You can use Provider to access your UserProvider and call a delete method
    Provider.of<UserProvider>(context, listen: false).deleteUserData(id);
  }
}
