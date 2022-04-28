import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(
                                Icons.no_accounts,
                              )),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password should not be empty.";
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  await _signInUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "Invalid email.Please enter a valid email address";
      case 'user-disabled':
        return "This user is disabled";
      case 'user-not-found':
        return "Coult not find user with this email address.";
      case 'wrong-password':
        return "Password is wrong.";

      default:
        return "Something is not right.Please try again later";
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: const [
              CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text('signing in...'),
            ],
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  bool _isUserValid() {
    final isValid = _formKey.currentState?.validate() ?? false;
    return isValid;
  }

  Future<void> _signInUser() async {
    if (!_isUserValid()) {
      return;
    }
    _showLoadingDialog();
    _signInToFirebase();
  }

  Future<void> _signInToFirebase() async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _hideLoadingDialog();
      _goToHomePage();
      print(userCredentials.user?.email);
    } on FirebaseAuthException catch (e) {
      _hideLoadingDialog();
      final errorMessage = _getErrorMessage(e);
      print(errorMessage);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _goToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }
}
