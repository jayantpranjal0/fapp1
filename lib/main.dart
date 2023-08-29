// import 'package:fapp1/firebase_options.dart';
// import 'package:fapp1/views/login_view.dart';
// import 'package:fapp1/views/register_view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fapp1/views/verify_email_view.dart';
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//       routes: {
//         '/login': (context) => const LoginView(),
//         '/register': (context) => const RegisterView(),
//       },
//     ),
//   );
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: FutureBuilder(
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               final user = FirebaseAuth.instance.currentUser;
//               print(user);
//               final emailVerified = user?.emailVerified ?? false;
//               if (emailVerified) {
//                 return const LoginView();
//               } else {
//                 return const VerifyEmailPage();
//               }
//             default:
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//           }
//         },
//       ),
//     );
//   }
// }



import 'package:fapp1/firebase_options.dart';
import 'package:fapp1/views/login_view.dart';
import 'package:fapp1/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fapp1/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;


enum MenuAction { logout }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            print(user);
            final emailVerified = user?.emailVerified ?? false;
            if (emailVerified) {
              return const NotesView();
            } else {
              return const VerifyEmailPage();
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                // showLogOutDialog(context).then((value) {
                //   if(value){
                //     FirebaseAuth.instance.signOut();
                //   }
                // });
                final shouldLogOut = await showLogOutDialog(context);
                devtools.log(shouldLogOut.toString());
                if (shouldLogOut) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (_) => false);
                }
                break;
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: const Text('Logout'),
              )
            ];
          })
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            )
          ],
        );
      }).then((value) => value ?? false);
}
