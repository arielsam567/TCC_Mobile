import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_mobile/Login/login_screen.dart';
import 'package:tcc_mobile/Mesario/AtualizaCompetidor/atualizaCompetidorMesario.dart';
import 'package:tcc_mobile/main.dart';

String identificadorCampeonato = campeonatoGlobal;
String ordenador = 'nome';
class MesarioScreen extends StatefulWidget {
  @override
  _MesarioScreenState createState() => _MesarioScreenState();
}

class _MesarioScreenState extends State<MesarioScreen>  with TickerProviderStateMixin {
  List<String>  _dbNomeCompetidor;
  List<String>  _dbIdCompetidor;
  List<String>  _dbEquipeCompetidor;
  List<String>  _dbSexoCompetidor;
  List<String>  _dbIdadeCompetidor;
  List<String>  _dbGraduacaoCompetidor;
  List<bool> _dbSelected;
  List<String>  listOrdenador= ['Nome','Equipe','Graduação','Sexo', 'Idade'];

  static const List<IconData> icons = const [Icons.exit_to_app];
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {

              ordenador = '${value.toLowerCase()}';
              if(ordenador  == 'graduação') {
                ordenador = 'graduacao';
              }
              print('$ordenador');
              consultaDocumentosCompetidores();
            },
            itemBuilder: (context) {
              return listOrdenador.map((index) {
                return PopupMenuItem(
                  value: index,
                  child: Text('$index'),
                );
              }).toList();
            },
          ),
        ],
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
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue),
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
              color: _dbSelected[index] ? Colors.lightGreen[100] : Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AtualizaCompetidorMesario(_dbIdCompetidor[index],identificadorCampeonato)),
                );
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
      _dbSelected = new List();
      databaseReference.collection("$identificadorCampeonato-Competidores")
          .orderBy('$ordenador')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          String nome = '${f.data['nome'].toString()}';
          _dbNomeCompetidor.add(nome);
          _dbEquipeCompetidor.add('${f.data['equipe'].toString()}');
          _dbIdadeCompetidor.add('${f.data['idade'].toString()}');
          _dbSexoCompetidor.add('${f.data['sexo'].toString()}');
          _dbIdCompetidor.add('${f.documentID}');
          _dbGraduacaoCompetidor.add('${f.data['graduacao'].toString()}');
          if(f.data['ARB1'] == true || f.data['ARB2'] == true){
            _dbSelected.add(true);
          }else{
            _dbSelected.add(false);
          }
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

}
