import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newzzie/app.dart';
import 'package:newzzie/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
  ], child: MyApp()));
}
