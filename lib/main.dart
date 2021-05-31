import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_dokumenku/shared/shared.dart';
import 'package:flutter_app_dokumenku/ui/pages/pages.dart';

void enablePlatformOverrideForDesktop(){
  if (!kIsWeb &&(Platform.isMacOS || Platform.isWindows ||Platform.isLinux)){
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async{
  enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced MAD",
      theme: MyTheme.lightTheme(),
      initialRoute: '/splash',
      //initialRoute: '/',
      routes : {
        Splash.routeName  : (context) => Splash(),
        Login.routeName : (context) => Login(),
        //'/': (context) => Login(),
        MainMenu.routeName : (context) => MainMenu(),
        Register.routeName : (context) => Register(),
      },
    );
  }
}