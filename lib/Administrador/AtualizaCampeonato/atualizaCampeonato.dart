import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:teste_requisicao/Administrador/AddCompetidor/addCompetidor.dart';
import 'package:teste_requisicao/Administrador/ListaCompetidores/CompetidoresScreen.dart';
import '../AdmScreen.dart';
import 'dart:math' as math;

String idCampeonato;

class AtualizaCampeonato extends StatefulWidget {

  AtualizaCampeonato(String id){
    idCampeonato = id;
  }

  @override
  _AtualizaCampeonatoState createState() => _AtualizaCampeonatoState();
}

class _AtualizaCampeonatoState extends State<AtualizaCampeonato> with TickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  TextEditingController _controllerNomeCampeonato =  new TextEditingController();
  TextEditingController _controllerLocalCampeonato =  new TextEditingController();
  TextEditingController _controllerUrlImgCampeonato =  new TextEditingController();
  TextEditingController _controllerIdentificadorCampeonato =  new TextEditingController();
  TextEditingController _controllerDataCampeonato =  new MaskedTextController(mask: '00-00-0000');

  List<TextEditingController>  _controllernNomeArbitro = [new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController()];
  List<TextEditingController>  _controllernSenhaArbitro = [new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController(),new TextEditingController()];

  TextEditingController _controllerMesarioNome =  new TextEditingController();
  TextEditingController _controllerMesarioSenha =  new TextEditingController();
  List<String>  _dbIdMesario= new List();

  List<String>  _dbIdArbitro = new List();

  static const List<IconData> icons = const [ Icons.person_pin, Icons.person_add, Icons.exit_to_app ];
  AnimationController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaCampeonato(idCampeonato);
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
                  if(index == 1 ){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => new AddCompetidor(_controllerIdentificadorCampeonato.text,idCampeonato))
                    );
                  }else if(index == 0 ){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new CompetidoresScreen(_controllerIdentificadorCampeonato.text)),
                    );
                  }else if(index == 2 ){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new AdmScreen()),
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CamposImput(),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ), //center
    );
  }

  // ignore: non_constant_identifier_names
  CamposImput(){
    return Container(
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery. of(context). size. width*0.8,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: AutoSizeText('${_controllerNomeCampeonato.text}',
                minFontSize: 15,
                maxFontSize: 30,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black45,),

                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            onChanged: (text){
              //_salvaData(text);
            },
            controller:  _controllerNomeCampeonato,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Nome do Campeonato',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.flag,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Nome do Campeonato',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Nome Campeonato
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            enabled: false,
            controller:  _controllerIdentificadorCampeonato,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Identificador do Campeonato',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.widgets,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Identificador do Campeonato',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Identificador Campeonato
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  _controllerDataCampeonato,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Data do Campeonato',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Data do Campeonato',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Data Campeonato
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  _controllerLocalCampeonato,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Local do Campeonato',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Local do Campeonato',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Local Campeonato
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  _controllerUrlImgCampeonato,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Url da Imagem do Campeonato',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Url da Imagem do Campeonato',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Url IMg
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  _controllerMesarioNome,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Nome do Mesario',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Nome do Mesario',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Nome Mesario
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  _controllerMesarioSenha,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Senha do Mesario',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Senha do Mesario',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),//Senha Mesario
        CamposArbitro(_controllernNomeArbitro[0],_controllernSenhaArbitro[0],'1'),
        CamposArbitro(_controllernNomeArbitro[1],_controllernSenhaArbitro[1],'2'),
        CamposArbitro(_controllernNomeArbitro[2],_controllernSenhaArbitro[2],'3'),
        CamposArbitro(_controllernNomeArbitro[3],_controllernSenhaArbitro[3],'4'),
        CamposArbitro(_controllernNomeArbitro[4],_controllernSenhaArbitro[4],'5'),//Img Campeonato
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdmScreen()),
                  );
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color.fromRGBO(161,255,121,1), Color.fromRGBO(182,255,135,1)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.22, minHeight: MediaQuery.of(context).size.height*0.13),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "VOLTAR",
                      maxLines: 1,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white ,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  atualizaCampeonato(idCampeonato);
                  atualizaArbitros();
                  atualizaMesario(_dbIdMesario[0]);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => new AdmScreen())
                  );
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color.fromRGBO(161,255,121,1), Color.fromRGBO(182,255,135,1)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.22, minHeight: MediaQuery.of(context).size.height*0.13),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "ATUALIZAR",
                      maxLines: 1,
                      minFontSize: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white ,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],),
    );

  }

  // ignore: non_constant_identifier_names
  CamposArbitro(TextEditingController controllerNome,controllerSenha, String posicao){
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: TextField(
            controller:  controllerNome,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Nome do Arbitro $posicao',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.flag,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Nome do Arbitro $posicao',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TextField(
            controller:  controllerSenha,
            style: TextStyle(color: Colors.black,),
            decoration: InputDecoration(
                labelText: 'Senha do Árbitro $posicao',
                labelStyle: TextStyle(color: Colors.black),
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                hintText: 'Senha do Árbitro $posicao',
                hintStyle: TextStyle(
                    fontSize: 15
                ),
                contentPadding: EdgeInsets.only(
                  top:5,
                  right:5,
                  left:15,
                  bottom: 1,
                )
            ),
          ),
        )
      ],
    );

  }

  void atualizaCampeonato(String id) async {
    try {
      await databaseReference.collection("Campeonatos")
          .document(id)
          .updateData({
        'data': '${_controllerDataCampeonato.text}',
        'local': '${_controllerLocalCampeonato.text}',
        'nome': '${_controllerNomeCampeonato.text}',
        'urlImg': '${_controllerUrlImgCampeonato.text}',
      });
      print("atualizado com sucesso");
    } catch (e) {
      print("-------ERRO ao atualizar campeonato------$e");
    }
  }

  void consultaCampeonato(String id) async {
    Firestore.instance.collection('Campeonatos').document('$id').get().then((docSnap) {
      _controllerNomeCampeonato.text = docSnap['nome'];
      _controllerDataCampeonato.text = docSnap['data'];
      _controllerLocalCampeonato.text = docSnap['local'];
      _controllerUrlImgCampeonato.text = docSnap['urlImg'];
      _controllerIdentificadorCampeonato.text = docSnap['identificador'];
      consultaArbitros();
      consultaMesario();
    });
  }

  consultaArbitros() async {
    try {
      _dbIdArbitro = new List();
      final databaseReference = Firestore.instance;
      int aux = 0;
      databaseReference.collection("${_controllerIdentificadorCampeonato.text}-Arbitros").orderBy('id')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            _controllernNomeArbitro[aux].text = '${f.data['nome']}';
            _controllernSenhaArbitro[aux].text = '${f.data['senha']}';
          });
          _dbIdArbitro.add('${f.documentID}');
          aux++;
        });

      });
    }catch(e){
      print(e);
    }
  }

  consultaMesario() async {
    try {
      print('entroi');
      _dbIdMesario = new List();
      final databaseReference = Firestore.instance;
      databaseReference.collection("${_controllerIdentificadorCampeonato.text}-Mesario")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          setState(() {
            print('${f.data['nome']}');
            _controllerMesarioNome.text = '${f.data['nome']}';
            _controllerMesarioSenha.text = '${f.data['senha']}';
          });
          _dbIdMesario.add('${f.documentID}');
        });
        print('sucesso ao pegar mesario');
      });
    }catch(e){
      print(e);
    }
  }

  void atualizaArbitros()  {
    try {
      int aux = 0;
      _dbIdArbitro.forEach((element)  {
        databaseReference.collection("${_controllerIdentificadorCampeonato.text}-Arbitros")
            .document(element)
            .updateData({
          'nome': '${_controllernNomeArbitro[aux].text}',
          'senha': '${_controllernSenhaArbitro[aux].text}',
        });
        //print('${_controllernSenhaArbitro[aux].text}');
        aux++;
      });

      print("atualizado com sucesso");
    } catch (e) {
      print("-------ERRO------$e");
    }
  }

  void atualizaMesario(String id)  {
    try {
      databaseReference.collection("${_controllerIdentificadorCampeonato.text}-Mesario")
          .document(id)
          .updateData({
        'nome': '${_controllerMesarioNome.text}',
        'senha': '${_controllerMesarioSenha.text}',
      });
      print("atualizado mesario com sucesso");
    } catch (e) {
      print("-------ERRO------$e");
    }
  }

}

