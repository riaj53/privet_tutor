import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privet_tutor/Student/presentation/welcome_screen.dart';
import 'package:privet_tutor/firebase_options.dart';
import 'package:privet_tutor/provider/auth_provider.dart';
import 'package:privet_tutor/student_or_tutor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'privet-tutor',
          home: WelcomeScreen(),
        ),
      );
    });
  }
}
