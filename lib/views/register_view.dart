import 'package:fapp1/constants/routes.dart';
import 'package:fapp1/utilities/showErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController,
                              password: passwordController);
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showErrorDialog(
                          context,
                          "Weak Password",
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showErrorDialog(
                          context,
                          "Email already in use",
                        );
                      } else if (e.code == 'invalid-email') {
                        showErrorDialog(
                          context,
                          "Invalid Email",
                        );
                      } else {
                        showErrorDialog(
                          context,
                          e.toString(),
                        );
                      }
                    } catch (e) {
                      showErrorDialog(
                        context,
                        e.toString(),
                      );
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
                              loginRoute, (route) => false);
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
