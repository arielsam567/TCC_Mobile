//import 'package:auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/Config/strings.dart';
import 'package:tcc_mobile/controller/home_controller.dart';
import 'package:tcc_mobile/view/login/login_screen.dart';
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

  @override
  void initState() {
    consultaDocumentosCompetidores();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
          builder: (BuildContext context, HomeController controller, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                title: Text(Strings.appName),
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
                onPressed: () {
                  userGlobal.name = '';
                  userGlobal.password = '';
                  userGlobal.campId = '';
                  userGlobal.userId = '';
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => new LoginScreen()));
                },
              ),
              body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Toque novamente para sair do app'),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/fundo2.png"),
                          fit: BoxFit.cover)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            child: AutoSizeText("Combates",
                              maxLines: 1,
                              maxFontSize: 50,
                              minFontSize: 25,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            )),
                        listView(_dbNomeCompetidor),
                      ],
                    ),
                  ),
                ),
              ), //center
            );
          }),
    );
  }

  Widget listView(List<String> items) {
    return ListView.builder(
      itemCount: (items.length),
      shrinkWrap: true,
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
      databaseReference.collection("${userGlobal.campId}-Competidores").orderBy('nome')
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
            _dbMediaCompetidor.add('${f.data['${userGlobal.userId}ng1'].toString()}');
            if(f.data['${userGlobal.userId}np1'].toString() != '0.00'){
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
            _dbMediaCompetidor.add('${f.data['${userGlobal.userId}ng2'].toString()}');
            print(_dbMediaCompetidor);
//            _dbNotaTec.add('${f.data['${valorArbitroGlobal}nt2'].toString()}');
//            _dbNotaExp.add('${f.data['${valorArbitroGlobal}ne2'].toString()}');
//            _dbNotaPot.add('${f.data['${valorArbitroGlobal}np2'].toString()}');
//            _dbNotaRit.add('${f.data['${valorArbitroGlobal}nr2'].toString()}');

            if(f.data['${userGlobal.userId}np2'].toString() != '0.00'){
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
