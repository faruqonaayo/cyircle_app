import 'package:cyircle_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var _showPassword = false;
  var _showConfirmPassword = false;
  var _enteredFirstName = "";
  var _enteredLastName = "";
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _enteredConfirmPassword = "";
  var _isSubmittingForm = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    if (_enteredPassword != _enteredConfirmPassword) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Unmatched Password!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          content: Text(
            "Passwords do not match. Please provide matching passwords",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingForm = true;
    });
    final authServices = AuthServices();

    final response = await authServices.signup(
      _enteredFirstName,
      _enteredLastName,
      _enteredEmail,
      _enteredPassword,
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response["message"]!,
          style: TextStyle(
            color: response["status"] == "success"
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onError,
          ),
        ),
        backgroundColor: response["status"] == "success"
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.error,
      ),
    );

    response["status"] == "success" ? Navigator.of(context).pop() : null;

    setState(() {
      _isSubmittingForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Create Account",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "Start keeping track of your items today!",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 40),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("First Name"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 2) {
                            return "First name field must not be less than 2 charracters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredFirstName = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Last Name"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 2) {
                            return "Last name field must not be less than 2 charracters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredLastName = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        validator: (value) {
                          final RegExp emailRegex = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                          );

                          if (value == null || !emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredEmail = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.none,
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return "Password must not be less than 6 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPassword = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Confirm Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                            child: Icon(
                              _showConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.none,
                        obscureText: !_showConfirmPassword,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return "Password must not be less than 6 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredConfirmPassword = newValue!;
                        },
                      ),
                      const SizedBox(height: 16),
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
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _isSubmittingForm
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Sign Up",
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
