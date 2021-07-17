import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc_mobile/Administrador/AtualizaCampeonato/atualizaCampeonato.dart';
import 'package:tcc_mobile/Login/login_screen.dart';

class AdmScreen extends StatefulWidget {
  @override
  _AdmScreenState createState() => _AdmScreenState();
}

class _AdmScreenState extends State<AdmScreen> with TickerProviderStateMixin {
  //final databaseReference = Firestore.instance;
  List<String>  _dbNomeCampeonato;
  List<String>  _dbIdentificadorCampeonato;
  List<String>  _dbDataCampeonato;
  List<String>  _dbLocalCampeonato;
  List<String>  _dbUrlImgCampeonato;
  List<String>  _dbIdCampeonato;

  // static const List<IconData> icons = const [Icons.exit_to_app ];
  // AnimationController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaDocumentosAdministrador();
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Dezdan - Poomsae Score'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        backgroundColor: Colors.black54,
        onPressed: () => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new LoginScreen()))
        },
      ),
      body: Container(
        width: MediaQuery.of(context). size.width,
        height: MediaQuery.of(context). size.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/loginFundo.jpg"),
                fit: BoxFit.cover)
        ),
        child: Column(
          children: <Widget>[
            new Expanded(child:geradorListView(_dbNomeCampeonato)),
          ],
        ),
      ), //center
    );
  }

  geradorListView(List<String> items) {

    return ListView.builder(
      itemCount: (items.length),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              //color: dbSelected[index] ? Colors.red[100] : Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AtualizaCampeonato(_dbIdCampeonato[index])),
                );
              },
              title: Text("Campeonato: " + '${_dbNomeCampeonato[index]}'),
              subtitle: Text('Data: ${_dbDataCampeonato[index]}    Local: ${_dbLocalCampeonato[index]}'),
            ),
          ),
        );
      },
    );
  }

  consultaDocumentosAdministrador() async {
    try {
      final databaseReference = Firestore.instance;
      _dbNomeCampeonato = new List();
      _dbDataCampeonato = new List();
      _dbLocalCampeonato = new List();
      _dbUrlImgCampeonato = new List();
      _dbIdCampeonato = new List();
      _dbIdentificadorCampeonato = new List();
      databaseReference.collection("Campeonatos").orderBy('nome')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          _dbNomeCampeonato.add('${f.data['nome'].toString()}');
          _dbDataCampeonato.add('${f.data['data'].toString()}');
          _dbUrlImgCampeonato.add('${f.data['urlImg'].toString()}');
          _dbLocalCampeonato.add('${f.data['local'].toString()}');
          _dbIdCampeonato.add('${f.documentID}');
          _dbIdentificadorCampeonato.add('${f.data['identificador'].toString()}');
        });
        setState(() {
          // ignore: unnecessary_statements
          _dbNomeCampeonato;
        });
      });
    }catch(e){
      print(e);
    }
  }
}
