import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../providers/user_provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: userProvider.form, // Provide the form group
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
                onPressed: () {
                  userProvider.addUser();
                  userProvider.resetForm(); // Reset the form fields
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
