import 'dart:developer';

import 'package:e_leaning/screens/course.dart';
import 'package:e_leaning/screens/coursetemp.dart';
import 'package:e_leaning/screens/facialfeedback.dart';
import 'package:e_leaning/screens/feedback.dart';
import 'package:e_leaning/screens/home.dart';
import 'package:e_leaning/screens/login.dart';
import 'package:e_leaning/screens/program.dart';
import 'package:e_leaning/screens/programtemp.dart';
import 'package:e_leaning/screens/register.dart';
import 'package:e_leaning/provider/courseprovider.dart';
import 'package:e_leaning/screens/tempcam.dart';
import 'package:e_leaning/screens/tempcamlast.dart';
import 'package:e_leaning/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<Courseprovider>(create: (_) => Courseprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Home(),
        MyRoutes.registerRoute: (context) => Registerscreen(),
        MyRoutes.loginRoute: (context) => Loginscreen(),
        MyRoutes.TempProgram: (context) => Programtemp(),
        MyRoutes.Tempcourse: (context) => Coursetemp(MyApp),
        MyRoutes.registerprogramRoute: (context) => Programscreen(),
        MyRoutes.registercourseRoute: (context) => Coursescreen(
              value: '',
            ),
        MyRoutes.feedabackRoute: (context) => Feedbackscreen(MyApp),
        MyRoutes.faicalfeedabackRoute: (context) => FacialFeedbackScreen(MyApp),
        MyRoutes.TempfaicalfeedabackRoute: (context) =>
            TempFacialFeedbackScreen(MyApp, hashCode, hashCode),
        MyRoutes.TempfaicalfeedabackRouteCheck: (context) =>
            TempFacialFeedbackScreenLast(),
      },
    );
  }
}
