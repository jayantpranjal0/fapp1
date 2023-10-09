import 'package:fapp1/constants/routes.dart';
import 'package:fapp1/views/login_view.dart';
import 'package:fapp1/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:fapp1/views/verify_email_view.dart';
import 'package:fapp1/views/notes_view.dart';
import 'package:fapp1/views/HomePage.dart';
// enum MenuAction { logout }

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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailPage(),
        notesRoute: ((context) => const NotesView()),
      },
    ),
  );
}


//
// class NotesView extends StatefulWidget {
//   const NotesView({super.key});
//
//   @override
//   State<NotesView> createState() => _NotesViewState();
// }
//
// class _NotesViewState extends State<NotesView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notes'),
//         actions: [
//           PopupMenuButton<MenuAction>(onSelected: (value) async {
//             switch (value) {
//               case MenuAction.logout:
//                 final shouldLogOut = await showLogOutDialog(context);
//                 devtools.log(shouldLogOut.toString());
//                 if (shouldLogOut) {
//                   await FirebaseAuth.instance.signOut();
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     loginRoute,
//                     (_) => false,
//                   );
//                 }
//                 break;
//             }
//           }, itemBuilder: (context) {
//             return [
//               const PopupMenuItem<MenuAction>(
//                 value: MenuAction.logout,
//                 child: Text('Logout'),
//               )
//             ];
//           })
//         ],
//       ),
//     );
//   }
// }

// Future<bool> showLogOutDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('No'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Yes'),
//             )
//           ],
//         );
//       }).then(
//     (value) => value ?? false,
//   );
// }
