import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:teste_requisicao/Login/login_screen.dart';
import '../main.dart';
import 'Poomsae/PoomsaeA.dart';

class ArbitroScreen extends StatefulWidget {
  @override
  _ArbitroScreenState createState() => _ArbitroScreenState();
}

class _ArbitroScreenState extends State<ArbitroScreen> with TickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  List<String>  _dbNomeCompetidor;
  List<String>  _dbIdCompetidor;
  List<String>  _dbEquipeCompetidor;
  List<String>  _dbSexoCompetidor;
  List<String>  _dbIdadeCompetidor;
  List<String>  _dbMediaCompetidor;
  List<String>  _dbGraduacaoCompetidor;
  List<bool>  _dbFlagCompetidor;
  List<bool>  _dbAva1;
  bool _flag = false;
//  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    consultaDocumentosCompetidores();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
//    _controller = new AnimationController(
//      vsync: this,
//      duration: const Duration(milliseconds: 500),
//    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Dezdan - Poomsae Score'),
        actions: <Widget>[
          IconButton(

            icon: Icon(Icons.autorenew),
            onPressed: () {
              consultaDocumentosCompetidores();
            },
          ),
        ],
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
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 40),
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
              color: _dbFlagCompetidor[index] ? Colors.purple[100] : _dbAva1[index] ? Colors.yellowAccent[100]: Colors.lightBlueAccent[100],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>
                  new PoomsaeA(_dbNomeCompetidor[index],
                      _dbEquipeCompetidor[index],
                      _dbIdCompetidor[index],
                      _dbMediaCompetidor[index],
                      _flag
                  )),
                );

              },
              title: _dbAva1[index] ? Text("Nome: " + '${_dbNomeCompetidor[index]}\nNota : ${_dbMediaCompetidor[index]}       ||      Avaliação 1', textAlign: TextAlign.center,) : Text("Nome: " + '${_dbNomeCompetidor[index]}\n Nota : ${_dbMediaCompetidor[index]}  || Avaliação 2', textAlign: TextAlign.center,),
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
      _dbMediaCompetidor = new List();
      _dbGraduacaoCompetidor = new List();
      _dbIdCompetidor = new List();
      _dbFlagCompetidor = new List();
      _dbAva1 = new List();
      databaseReference.collection("$campeonatoGlobal-Competidores").orderBy('nome')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          if(f.data['ARB1'] && !f.data['ARB2']) {
            _dbAva1.add(true);
            _dbNomeCompetidor.add('${f.data['nome'].toString()}');
            _dbEquipeCompetidor.add('${f.data['equipe'].toString()}');
            _dbIdadeCompetidor.add('${f.data['idade'].toString()}');
            _dbSexoCompetidor.add('${f.data['sexo'].toString()}');
            _dbIdCompetidor.add('${f.documentID}');
            _dbGraduacaoCompetidor.add('${f.data['graduacao'].toString()}');
            _dbMediaCompetidor.add('${f.data['${valorArbitroGlobal}ng1'].toString()}');
            // print(_dbMediaCompetidor);
//            _dbNotaTec.add('${f.data['${valorArbitroGlobal}nt1'].toString()}');
//            _dbNotaExp.add('${f.data['${valorArbitroGlobal}ne1'].toString()}');
//            _dbNotaPot.add('${f.data['${valorArbitroGlobal}np1'].toString()}');
//            _dbNotaRit.add('${f.data['${valorArbitroGlobal}nr1'].toString()}');
            if(f.data['${valorArbitroGlobal}np1'].toString() != '0.00'){
              _dbFlagCompetidor.add(true);
            }else{
              _dbFlagCompetidor.add(false);
            }
          }
          else if(f.data['ARB2'] && !f.data['ARB1']) {
            _dbAva1.add(false);
            _flag = true;
            _dbNomeCompetidor.add('${f.data['nome'].toString()}');
            _dbEquipeCompetidor.add('${f.data['equipe'].toString()}');
            _dbIdadeCompetidor.add('${f.data['idade'].toString()}');
            _dbSexoCompetidor.add('${f.data['sexo'].toString()}');
            _dbIdCompetidor.add('${f.documentID}');
            _dbGraduacaoCompetidor.add('${f.data['graduacao'].toString()}');
            _dbMediaCompetidor.add('${f.data['${valorArbitroGlobal}ng2'].toString()}');
            print(_dbMediaCompetidor);
//            _dbNotaTec.add('${f.data['${valorArbitroGlobal}nt2'].toString()}');
//            _dbNotaExp.add('${f.data['${valorArbitroGlobal}ne2'].toString()}');
//            _dbNotaPot.add('${f.data['${valorArbitroGlobal}np2'].toString()}');
//            _dbNotaRit.add('${f.data['${valorArbitroGlobal}nr2'].toString()}');

            if(f.data['${valorArbitroGlobal}np2'].toString() != '0.00'){
              _dbFlagCompetidor.add(true);
            }else{
              _dbFlagCompetidor.add(false);
            }
          }
        }
        );
        setState(() {
          // ignore: unnecessary_statements
          _dbFlagCompetidor;
          // ignore: unnecessary_statements
          _dbNomeCompetidor;
        });
      });
    }catch(e){
      print(e);
    }
  }
}
