// import 'package:booktopia/widget/settings_title.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// //import 'package:settings_screen_tutorial/widgets/settings_tile.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Settings",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 40),
//               Settings(
//                 color: Colors.blue,
//                 icon: Ionicons.person_circle_outline,
//                 title: "Change Password",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Settings(
//                 color: Colors.green,
//                 icon: Ionicons.pencil_outline,
//                 title: "Rule",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Settings(
//                 color: Colors.black,
//                 icon: Ionicons.moon_outline,
//                 title: "Theme",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Settings(
//                 color: Colors.purple,
//                 icon: Ionicons.language_outline,
//                 title: "Language",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Settings(
//                color: Colors.red,
//                 icon: Ionicons.log_out_outline,
//                 title: "Logout",
//                 onTap: () {},
//               ), 
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
