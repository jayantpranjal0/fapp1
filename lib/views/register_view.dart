import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    )),
                TextField(
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    )),
                ElevatedButton(
                  onPressed: () async {
                    final emailController = _emailController.text;
                    final passwordController = _passwordController.text;
                    // ignore: unused_local_variable
                    late final UserCredential userCredential;
                    try {
                      userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController,
                              password: passwordController);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        devtools.log('Weak Password');
                      } else if (e.code == 'email-already-in-use') {
                        devtools.log('Email already in use');
                      } else if (e.code == 'invalid-email') {
                        devtools.log('Invalid Email');
                      } else {
                        devtools.log('Something unexpected happened $e.code');
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                Row(
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        },
                        child: const Text('Login ')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
