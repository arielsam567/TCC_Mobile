import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/Login/login_screen.dart';


double widthGlobal;
double heightGlobal;

String nomeUsuarioGlobal = '';
String senhaUsuarioGlobal = '';
String campeonatoGlobal = '';
String tipoUsuarioGlobal = 'Árbitro';




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
  tipoUsuarioGlobal = (prefs.getString('tipoUsuarioGlobal') ??  'Administrador');
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

void consultaDocumentosLogin() async {
  try {
    final databaseReference = Firestore.instance;
    if (tipoUsuarioGlobal == 'Árbitro') {
      databaseReference.collection("$campeonatoGlobal-Arbitros").getDocuments().then((
          QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          bool status = f.data['status'];
          print(status);
          if(!status) {
            dbNomeArbitros = '${f.data['nome']}';
            dbSenhasArbitros = '${f.data['senha']}';
            dbIdArbitro = '${f.data['id']}';
          }
          //print(dbNomeArbitros);
        });
      });

    }
  }catch(e){
    print(e);
  }
}

