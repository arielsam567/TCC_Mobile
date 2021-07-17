import 'dart:core';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_mobile/Mesario/MesarioScreen.dart';
import 'package:tcc_mobile/Mesario/ShareScreen/ShareScreen.dart';

String _idCompetidor;
String _identificadorCampeonato;

class AtualizaCompetidorMesario extends StatefulWidget {
  AtualizaCompetidorMesario(String idComp, idCamp) {
    _idCompetidor = idComp;
    _identificadorCampeonato = idCamp;
  }

  @override
  _AtualizaCompetidorMesarioState createState() =>
      _AtualizaCompetidorMesarioState();
}

class _AtualizaCompetidorMesarioState extends State<AtualizaCompetidorMesario> {
  final databaseReference = Firestore.instance;
  TextEditingController _controllerNomeCompetidor = new TextEditingController();
  TextEditingController _controllerEquipeCompetidor =
      new TextEditingController();
  List<String> _tipoGraduacao = [
    'Iniciante',
    'Intermediario',
    'Avançado',
    'Preta'
  ];
  String _categoriaGraduacao = 'Iniciante';
  var _tipoIdade = [
    'Mirim Sub-8',
    'Infantil Sub-11',
    'Cadete Sub-14',
    'Junior Sub-17',
    'Adulto',
    'Master 1',
    'Master 2',
    'Master 3',
    'Master 4',
    'Master 5',
    'Master 6'
  ];
  String _categoriaIdade = 'Mirim Sub-8';
  List<String> _tipoSexo = ['Masculino', 'Feminino'];
  String _categoriaSexo = 'Masculino';
  bool _dbSwitchButton1 = false;
  bool _dbSwitchButton2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaCompetidor();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dezdan - Poomsae Score'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/loginFundo.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CamposInput(),
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
  CamposInput() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: AutoSizeText(
              'ATUALIZA COMPETIDOR',
              minFontSize: 25,
              maxFontSize: 30,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          AddCampoInput(_controllerNomeCompetidor, 'Nome', Icons.person_pin),
          AddCampoInput(_controllerEquipeCompetidor, 'Equipe', Icons.flag),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              returnCampoChoiceBoxIdade(),
              returnCampoChoiceBoxGraduacao(),
            ],
          ),
          returnCampoChoiceBoxSexo(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              returnSwitchA('Avaliação 1 '),
              returnSwitchB('Avaliação 2'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MesarioScreen()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(161, 255, 121, 1),
                            Color.fromRGBO(182, 255, 135, 1)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.22,
                          minHeight: MediaQuery.of(context).size.height * 0.13),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "VOLTAR",
                        maxLines: 1,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
//                  Navigator.of(context).pushReplacement(
//                    MaterialPageRoute(builder: (context) => new ShareScreen(_controllerNomeCompetidor.text, _controllerEquipeCompetidor.text, idCompetidor)),
//                  );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new ShareScreen(
                              _controllerNomeCompetidor.text,
                              _controllerEquipeCompetidor.text,
                              _idCompetidor)),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(161, 255, 121, 1),
                            Color.fromRGBO(182, 255, 135, 1)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                          minHeight: MediaQuery.of(context).size.height * 0.13),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "COMPARTILHAR\nTELA",
                        maxLines: 2,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ), //VOLTAR
            ],
          ),
        ],
      ),
    );
  }

  void atualizaSwitch(bool estado, String dado) async {
    try {
      await databaseReference
          .collection("$_identificadorCampeonato-Competidores")
          .document('$_idCompetidor')
          .updateData({
        '$dado': estado,
      });
      print("atualizado com sucesso COMPETIDOR");
    } catch (e) {
      print("-------ERRO AO ADICIONAR COMPETIDOR------$e");
    }
  }

  void consultaCompetidor() async {
    print(_idCompetidor);
    Firestore.instance
        .collection('$_identificadorCampeonato-Competidores')
        .document('$_idCompetidor')
        .get()
        .then((docSnap) {
      _controllerNomeCompetidor.text = docSnap['nome'];
      _controllerEquipeCompetidor.text = docSnap['equipe'];
      setState(() {
        _categoriaGraduacao = docSnap['graduacao'];
        _categoriaIdade = docSnap['idade'];
        _categoriaSexo = docSnap['sexo'];
        _dbSwitchButton1 = docSnap['ARB1'];
        _dbSwitchButton2 = docSnap['ARB2'];
      });
    });
  }

  // ignore: non_constant_identifier_names
  AddCampoInput(
      TextEditingController controller, String nomeCampo, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
            enabled: false,
            labelText: nomeCampo,
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            border: OutlineInputBorder(),
            hintText: nomeCampo,
            hintStyle: TextStyle(fontSize: 15),
            contentPadding: EdgeInsets.only(
              top: 5,
              right: 5,
              left: 15,
              bottom: 1,
            )),
      ),
    );
  }

  returnCampoChoiceBoxSexo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
              items: _tipoSexo.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String opcao) {},
              value: _categoriaSexo,
            ),
          ),
        ],
      ),
    );
  }

  returnCampoChoiceBoxIdade() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
              items: _tipoIdade.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String opcao) {},
              value: _categoriaIdade,
            ),
          ),
        ],
      ),
    );
  }

  returnCampoChoiceBoxGraduacao() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
              items: _tipoGraduacao.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String opcao) {},
              value: _categoriaGraduacao,
            ),
          ),
        ],
      ),
    );
  }

  returnSwitchA(String texto) {
    return Row(
      children: <Widget>[
        Center(
            child: Switch(
          value: _dbSwitchButton1,
          onChanged: (value) {
            setState(() {
              _dbSwitchButton1 = value;
            });
            atualizaSwitch(value, 'ARB1');
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        )),
        Text(texto),
      ],
    );
  }

  returnSwitchB(String texto) {
    return Row(
      children: <Widget>[
        Center(
            child: Switch(
          value: _dbSwitchButton2,
          onChanged: (value) {
            setState(() {
              _dbSwitchButton2 = value;
            });
            atualizaSwitch(value, 'ARB2');
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        )),
        Text(texto),
      ],
    );
  }
}

/*
_showDialogAviso() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Atenção"),
          content: new Text("Não foi possivel criar este Campeonato, pois já existe um Identificador igual a este.\nAltere o Identificador"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


* */
