// lib/presentation/screens/edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../Business_layer/entites/user_data.dart';
import '../providers/user_provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late UserData userData;

  //@override
  // void initState() {
  //   super.initState();
  //   final args = ModalRoute.of(context)?.settings.arguments
  //       as Map<String, dynamic>?; // Get the userData from arguments
  //   userData = args?['userData'] as UserData;
  //   Provider.of<UserProvider>(context, listen: false)
  //       .setUserData(userData); // Set the user data in the form group
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments
        as Map<String, dynamic>?; // Get the userData from arguments
    userData = args?['userData'] as UserData;
    Provider.of<UserProvider>(context, listen: false)
        .setUserData(userData); // Set the user data in the form group
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: userProvider.form,
          child: Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              ReactiveTextField<int>(
                formControlName: 'age',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),
              ReactiveTextField<String>(
                formControlName: 'gender',
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 10),
              ReactiveDropdownField<String>(
                formControlName: 'city',
                items: userProvider.cities
                    .map((city) =>
                        DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 10),
              ReactiveTextField<String>(
                formControlName: 'address',
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await userProvider.updateUser(userData);
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
