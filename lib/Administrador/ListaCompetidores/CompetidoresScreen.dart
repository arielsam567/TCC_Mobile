import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:teste_requisicao/Administrador/AtualizaCompetidor/atualizaCompetidor.dart';
import 'dart:math' as math;


String identificadorCampeonato;
class CompetidoresScreen extends StatefulWidget {

  CompetidoresScreen(String idCamp){
    identificadorCampeonato = idCamp;
  }
  @override
  _CompetidoresScreenState createState() => _CompetidoresScreenState();
}

class _CompetidoresScreenState extends State<CompetidoresScreen>  with TickerProviderStateMixin  {
  final databaseReference = Firestore.instance;
  List<String>  _dbNomeCompetidor;
  List<String>  _dbIdCompetidor;
  List<String>  _dbEquipeCompetidor;
  List<String>  _dbSexoCompetidor;
  List<String>  _dbIdadeCompetidor;
  List<String>  _dbGraduacaoCompetidor;
  List<String> imagePaths = [];

  static const List<IconData> icons = const [Icons.share ];
  AnimationController _controller;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaDocumentosCompetidores();
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
                    _onShare(context);
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
                            child: AutoSizeText("Competidores",
                              maxLines: 1,
                              maxFontSize: 50,
                              minFontSize: 25,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),

                      ],
                    )),
              ],
            ),
            new Expanded(child:geradorListView(_dbNomeCompetidor)),
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
                print(_dbIdCompetidor[index]);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AtualizaCompetidor(_dbIdCompetidor[index],identificadorCampeonato)),
                );
              },
              onLongPress: () {
                _showDialogDelete(_dbIdCompetidor[index]);
              },
              title: Text("Nome: " + '${_dbNomeCompetidor[index]}'),
              subtitle: Text('Equipe: ${_dbEquipeCompetidor[index]}         Sexo: ${_dbSexoCompetidor[index]}\n'
                  'Idade: ${_dbIdadeCompetidor[index]}        Graduação: ${_dbGraduacaoCompetidor[index]}'),
            ),
          ),
        );
      },
    );
  }

  consultaDocumentosCompetidores() async {
    try {
      final databaseReference = Firestore.instance;
      _dbNomeCompetidor = new List();
      _dbEquipeCompetidor = new List();
      _dbSexoCompetidor = new List();
      _dbIdadeCompetidor = new List();
      _dbGraduacaoCompetidor = new List();
      _dbIdCompetidor = new List();
      databaseReference.collection("$identificadorCampeonato-Competidores").orderBy('nome')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          _dbNomeCompetidor.add('${f.data['nome'].toString()}');
          _dbEquipeCompetidor.add('${f.data['equipe'].toString()}');
          _dbIdadeCompetidor.add('${f.data['idade'].toString()}');
          _dbSexoCompetidor.add('${f.data['sexo'].toString()}');
          _dbIdCompetidor.add('${f.documentID}');
          _dbGraduacaoCompetidor.add('${f.data['graduacao'].toString()}');
        });
        setState(() {
          // ignore: unnecessary_statements
          _dbNomeCompetidor;
        });
      });
    }catch(e){
      print(e);
    }
  }

  _showDialogDelete(String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Atenção"),
          content: new Text("Deseja excluir esse Competidor?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Confirmar"),
              onPressed: () {
                deletaDocumento(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deletaDocumento(String id) {
    try {
      databaseReference
          .collection('$identificadorCampeonato-Competidores')
          .document('$id')
          .delete();
      print("Sucesso ao deletar ");
      consultaDocumentosCompetidores();
    } catch (e) {
      print(e.toString());
    }
  }

  _onShare(BuildContext context) async {
    Share.share('Some text here',
        subject: 'Update the coordinate!',
        sharePositionOrigin: Rect.fromLTWH(0, 0, 50, 50)
    );
  }
}
