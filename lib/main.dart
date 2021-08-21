import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/view/login/login_screen.dart';
import 'config/config.dart';
import 'model/user_model.dart';


UserModel userGlobal;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name =  (prefs.getString(Config.shareName) ??  '');
  String password =  (prefs.getString(Config.sharePassword) ??  '');
  String campId = (prefs.getString(Config.shareCamp) ??  '');
  userGlobal = UserModel(name, password, campId, '');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCC - MOBILE',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


