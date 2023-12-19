import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/welcome_screen.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              ap.userSignOut().then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())));
            },
            icon: Icon(Icons.exit_to_app)),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 50,
            ),
            Text(ap.userModel.name),
            Text(ap.userModel.email),
            Text(ap.userModel.phoneNumber),
            Text(ap.userModel.bio),
          ],
        ),
      ),
    );
  }
}
