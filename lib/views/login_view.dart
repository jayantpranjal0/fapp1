import 'package:fapp1/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fapp1/utilities/showErrorDialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        appBar: AppBar(
          title: const Text('Login'),
        ),
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
                    late final UserCredential userCredential;
                    try {
                      userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController,
                              password: passwordController);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute, (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showErrorDialog(
                          context,
                          "User not found!",
                        );
                      } else if (e.code == 'wrong-password') {
                        showErrorDialog(
                          context,
                          "Wrong Password",
                        );
                      } else {
                        showErrorDialog(
                          context,
                          "Error: ${e.code}",
                        );
                      }
                    } catch (e) {
                      showErrorDialog(
                        context,
                        e.toString(),
                      );
                    }
                  },
                  child: const Text('Log In'),
                ),
                Row(
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              registerRoute, (route) => false);
                        },
                        child: const Text('Register')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}