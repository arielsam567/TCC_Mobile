import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/Login/login_screen.dart';



String nomeUsuarioGlobal = '';
String senhaUsuarioGlobal = '';
String campeonatoGlobal = '';



String dbNomeArbitros;
String dbSenhasArbitros;
String dbIdArbitro;
String valorArbitroGlobal;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  nomeUsuarioGlobal =  (prefs.getString('nomeUsuarioGlobal') ??  '');
  senhaUsuarioGlobal =  (prefs.getString('senhaUsuarioGlobal') ??  '');
  campeonatoGlobal = (prefs.getString('campeonatoGlobal') ??  '');
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

Future<void> consultaDocumentosLogin() async {
  try {
    final databaseReference = Firestore.instance;
    await databaseReference.collection("$campeonatoGlobal-Arbitros").getDocuments().then((
        QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        bool fechado = f.data['fechado'];

        if(fechado == false) {
          String auxName = '${f.data['nome']}';
          if(auxName == nomeUsuarioGlobal) {
            print('igual');
            dbNomeArbitros = auxName;
            dbSenhasArbitros = '${f.data['senha']}';
            dbIdArbitro = '${f.data['id']}';
          }
        }
      });
    });
  }catch(e){
    print(e);
  }
}

