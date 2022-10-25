import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sesa/ui/views/login_page/login_page.dart';
import 'package:sesa/ui/views/main_page.dart';
import 'package:sesa/ui/views/splash_screen/splash_screen.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(
        const ProviderScope(
          child: MainPageAPP(),
        ),
      ),
      onNotLogin: () => runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SESA',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home': (BuildContext _context) => LoginPage(),
      },
    );
  }
}

class MainPageAPP extends StatelessWidget {
  const MainPageAPP({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SESA',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home': (BuildContext _context) => MainPage(),
      },
    );
  }
}
