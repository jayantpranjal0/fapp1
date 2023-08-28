import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('LogIn'),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                              )),
                          TextField(
                              controller: _passwordController,
                              obscureText: true,
                              autocorrect: false,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              )),
                          ElevatedButton(
                            onPressed: () async {
                              final emailController = _emailController.text;
                              final passwordController =
                                  _passwordController.text;
                              late final userCredential;
                              try {
                                userCredential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController,
                                        password: passwordController);
                                print(userCredential);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided for that user.');
                                }
                                else{
                                  print('Something went wrong $e.code');
                                }
                              }
                            },
                            child: const Text('Log In'),
                          ),
                        ],
                      ),
                    ),
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}
