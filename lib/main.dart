import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_requisicao/Login/login_screen.dart';

//5 --split-per-abi
//flutter pub run flutter_launcher_icons:main
//C:\Program Files\Android\Android Studio\jre\bin
//keytool -genkey -v -keystore c:\Users\USER_NAME\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key

double widthGlobal;
double heightGlobal;

String nomeUsuarioGlobal = 'MESARIO';
String senhaUsuarioGlobal = 'MESARIO55';
String campeonatoGlobal = 'CAMP34';
String tipoUsuarioGlobal = '';
String avisoErro = '';

List<String> dbNomeAdms = new List();
List<String> dbSenhasAdms = new List();

List<String> dbNomeArbitros = new List();
List<String> dbSenhasArbitros = new List();
List<String> dbIdArbitro= new List();
String valorArbitroGlobal;

List<String> dbCampeonato = new List();

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
    if (tipoUsuarioGlobal == 'Administrador') {
      print("csdsf");
      dbNomeAdms = new List();
      dbSenhasAdms = new List();
      databaseReference.collection("Administrador").orderBy('nome')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          print(f.data['nome']);
          print(f.data['nome']);
          dbNomeAdms.add('${f.data['nome'].toString()}');
          dbSenhasAdms.add('${f.data['senha'].toString()}');
        });
      });
    }

    if (tipoUsuarioGlobal == 'Árbitro') {
      dbNomeArbitros = new List();
      dbSenhasArbitros = new List();
      dbIdArbitro = new List();
      databaseReference.collection("$campeonatoGlobal-Arbitros").getDocuments().then((
          QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          bool status = f.data['status'];
          print(status);
          if(!status) {
            dbNomeArbitros.add('${f.data['nome'].toString()}');
            dbSenhasArbitros.add('${f.data['senha'].toString()}');
            dbIdArbitro.add('${f.data['id'].toString()}');
          }
          //print(dbNomeArbitros);
        });
      });

    }

    if (tipoUsuarioGlobal == 'Mesario') {
      dbNomeArbitros = new List();
      dbSenhasArbitros = new List();
      dbIdArbitro = new List();
      databaseReference.collection("$campeonatoGlobal-Mesario").getDocuments().then((
          QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          dbNomeArbitros.add('${f.data['nome'].toString()}');
          dbSenhasArbitros.add('${f.data['senha'].toString()}');

        });
      });

    }
  }catch(e){
    print(e);
  }
}

