import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newzzie/providers/theme_provider.dart';
import 'package:newzzie/views/homepage.dart';
import 'package:newzzie/views/login_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'NewzziE',
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Color(0xFF44c2c7),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   textButtonTheme: TextButtonThemeData(
      //     style: TextButton.styleFrom(
      //       primary: Color(0xFF44c2c7),
      //     ),
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       primary: Color(0xFF44c2c7),
      //     ),
      //   ),
      // ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginView();
            }
          }
        },
      ),
    );
  }
}
