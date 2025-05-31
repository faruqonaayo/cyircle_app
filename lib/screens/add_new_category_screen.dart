import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cyircle_app/models/category.dart';
import 'package:cyircle_app/providers/my_category_provider.dart';
import 'package:cyircle_app/services/category_service.dart';

class AddNewCategoryScreen extends ConsumerStatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  ConsumerState<AddNewCategoryScreen> createState() =>
      _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends ConsumerState<AddNewCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  Color _selectedColor = Colors.blue;
  var _isSubmittingForm = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    // You can handle your form submission here (e.g., save to database or call an API)

    final alphaValue = (_selectedColor.a * 255).round();
    final redValue = (_selectedColor.r * 255).round();
    final greenValue = (_selectedColor.g * 255).round();
    final blueValue = (_selectedColor.b * 255).round();

    Category newCategory = Category(
      name: _enteredName,
      description: _enteredDescription,
      colors: [alphaValue, redValue, greenValue, blueValue],
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    setState(() {
      _isSubmittingForm = true;
    });

    final response = await CategoryService().saveCategory(newCategory);

    if (!mounted) {
      return;
    }
    // Reset the form after submission if needed
    setState(() {
      _isSubmittingForm = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response != null
              ? "Category '${newCategory.name}' added successfully!"
              : "Category not added",
          style: TextStyle(
            color: response != null
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onError,
          ),
        ),
        backgroundColor: response != null
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.error,
      ),
    );

    if (response != null) {
      newCategory.id = response.id;
      _formKey.currentState!.reset();
      final myCategoryProviderNotifier = ref.read(myCategoryProvider.notifier);
      myCategoryProviderNotifier.addCategory(newCategory);
    }
  }

  void _pickColor() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (value) {
              setState(() {
                _selectedColor = value;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Category')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add New Category",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Category Name"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 2) {
                            return "Category name must be at least 2 characters.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredName = newValue!;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Description"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Description cannot be empty.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredDescription = newValue!;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Pick Color:"),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: _pickColor,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _selectedColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSubmittingForm ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isSubmittingForm
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Add Category",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
