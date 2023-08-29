// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../firebase_options.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   late final TextEditingController _emailController;
//   late final TextEditingController _passwordController;

//   @override
//   void initState() {
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: const Text('Register'),
//         ),
//         body: FutureBuilder(
//             future: Firebase.initializeApp(
//               options: DefaultFirebaseOptions.currentPlatform,
//             ),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.done:
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           TextField(
//                               controller: _emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               autocorrect: false,
//                               enableSuggestions: true,
//                               decoration: const InputDecoration(
//                                 labelText: 'Email',
//                                 hintText: 'Enter your email',
//                               )),
//                           TextField(
//                               controller: _passwordController,
//                               obscureText: true,
//                               autocorrect: false,
//                               enableSuggestions: true,
//                               decoration: const InputDecoration(
//                                 labelText: 'Password',
//                                 hintText: 'Enter your password',
//                               )),
//                           ElevatedButton(
//                             onPressed: () async {
//                               final emailController = _emailController.text;
//                               final passwordController =
//                                   _passwordController.text;
//                               late final UserCredential userCredential;
//                               try {
//                                 userCredential = await FirebaseAuth.instance
//                                     .createUserWithEmailAndPassword(
//                                         email: emailController,
//                                         password: passwordController);
//                                 print(userCredential);
//                               } on FirebaseAuthException catch (e) {
//                                 if(e.code=='weak-password'){
//                                   print('Weak Password');
//                                 }
//                                 else if(e.code=='email-already-in-use'){
//                                   print('Email already in use');
//                                 }
//                                 else if(e.code=='invalid-email'){
//                                   print('Invalid Email');
//                                 }
//                                 else{
//                                   print('Something unexpected happened $e.code');
//                                 }
//                               }
//                             },
//                             child: const Text('Sign Up'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 default:
//                   return const Center(child: CircularProgressIndicator());
//               }
//             }),
//       );
// }
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
                    late final UserCredential userCredential;
                    try {
                      userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController,
                              password: passwordController);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('Weak Password');
                      } else if (e.code == 'email-already-in-use') {
                        print('Email already in use');
                      } else if (e.code == 'invalid-email') {
                        print('Invalid Email');
                      } else {
                        print('Something unexpected happened $e.code');
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
