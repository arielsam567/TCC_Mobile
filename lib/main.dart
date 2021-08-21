import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/view/login/login_screen.dart';

import 'model/user_model.dart';


UserModel userGlobal;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name =  (prefs.getString('nomeUsuarioGlobal') ??  '');
  String passw =  (prefs.getString('senhaUsuarioGlobal') ??  '');
  String campId = (prefs.getString('campeonatoGlobal') ??  '');
  userGlobal = UserModel(name, passw, campId, '');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


