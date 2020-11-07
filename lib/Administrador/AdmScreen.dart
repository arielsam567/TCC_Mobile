import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_requisicao/Administrador/AtualizaCampeonato/atualizaCampeonato.dart';
import 'package:teste_requisicao/Login/login_screen.dart';
import 'dart:math' as math;

import 'addCampeonato/addCampeonato.dart';

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

  static const List<IconData> icons = const [Icons.exit_to_app ];
  AnimationController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaDocumentosAdministrador();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dezdan - Poomsae Score'),
      ),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                    0.0,
                    1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut
                ),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {
                  print([index]);
                  if(index == 0 ){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => new LoginScreen())
                    );
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.add_circle_outline : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
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
            Stack(
              children: <Widget>[
                Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          child: RaisedButton(
                            onPressed: () {
//                              Navigator.of(context).pushReplacement(
//                                MaterialPageRoute(builder: (context) => AddCampeonato(_dbIdentificadorCampeonato)),
//                              );
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints( minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "ADICIONAR CAMPEONATO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )),
              ],
            ),
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
