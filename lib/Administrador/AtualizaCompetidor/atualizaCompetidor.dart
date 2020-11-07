import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String idCompetidor;
String identificadorCampeonato;
List<String> idsExistentes = new List();
class AtualizaCompetidor extends StatefulWidget {

  AtualizaCompetidor(String idComp,idCamp){
    idCompetidor = idComp;
    identificadorCampeonato = idCamp;
  }

  @override
  _AtualizaCompetidorState createState() => _AtualizaCompetidorState();
}

class _AtualizaCompetidorState extends State<AtualizaCompetidor> {
  final databaseReference = Firestore.instance;
  TextEditingController _controllerNomeCompetidor =  new TextEditingController();
  TextEditingController _controllerEquipeCompetidor =  new TextEditingController();

  List<String> _tipoGraduacao =['Iniciante','Intermediário', 'Avançado' , 'Preta'];
  String _categoriaGraduacao = 'Iniciante';

  var _tipoIdade =['Mirim Sub-8','Infantil Sub-11', 'Cadete Sub-14', 'Junior Sub-17', 'Adulto',
    'Master 1', 'Master 2', 'Master 3', 'Master 4', 'Master 5', 'Master 6'];
  String _categoriaIdade = 'Mirim Sub-8';

  List<String> _tipoSexo=['Masculino','Feminino'];
  String _categoriaSexo = 'Masculino';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaCompetidor();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dezdan - Poomsae Score'),
      ),
      body: Container(
          width : MediaQuery.of(context). size.width,
        height : MediaQuery.of(context). size.height,

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
  CamposInput(){
    return Container(
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery. of(context). size. width*0.8,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: AutoSizeText('ATUALIZAR COMPETIDOR',
            minFontSize: 15,
            maxFontSize: 30,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey),),
        ),
        AddCampoInput(_controllerNomeCompetidor, 'Nome',  Icons.person_pin),
        AddCampoInput(_controllerEquipeCompetidor, 'Equipe',  Icons.accessible_forward),
        returnCampoChoiceBoxSexo(),
        returnCampoChoiceBoxIdade(),
        returnCampoChoiceBoxGraduacao(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
            ), //VOLTAT
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  bool validador = false;
                  if(!validador) {
                    atualizaCompetidor();
                    Navigator.of(context).pop();
                  }else{
                    _showDialogAviso();
                  }
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
            ), //ADICIONAR
          ],
        ),
      ],),
    );

  }

  void atualizaCompetidor() async {
    try {
      await databaseReference.collection("$identificadorCampeonato-Competidores")
          .document('$idCompetidor')
          .updateData({
        'nome': '${_controllerNomeCompetidor.text}',
        'equipe': '${_controllerEquipeCompetidor.text}',
        'sexo': '$_categoriaSexo',
        'idade': '$_categoriaIdade',
        'graduacao': '$_categoriaGraduacao',
      });
      print("atualizadp com sucesso COMPETIDOR");

    } catch (e) {
      print("-------ERRO AO ADICIONAR COMPETIDOR------$e");
    }
  }

  void consultaCompetidor() async {
    print(idCompetidor);
    Firestore.instance.collection('$identificadorCampeonato-Competidores').document('$idCompetidor').get().then((docSnap) {
      _controllerNomeCompetidor.text = docSnap['nome'];
      _controllerEquipeCompetidor.text = docSnap['equipe'];
      setState(() {
        _categoriaGraduacao = docSnap['graduacao'];
        _categoriaIdade = docSnap['idade'];
        _categoriaSexo = docSnap['sexo'];
      });
    });
  }

  // ignore: non_constant_identifier_names
  AddCampoInput(TextEditingController controller, String nomeCampo,IconData icon ){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: TextField(
        controller:  controller,
        style: TextStyle(color: Colors.black,),
        decoration: InputDecoration(
            labelText: nomeCampo,
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            border: OutlineInputBorder(),
            hintText: nomeCampo,
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
    );
  }

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

  returnCampoChoiceBoxSexo() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.only(
            top: 5,
            bottom:5,
            left:10,
            right: 10
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color:  Colors.black45,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<String>(
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
          items : _tipoSexo.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: ( String opcao) {
            setState(() {
              print(opcao);
              _categoriaSexo =  opcao;
              //print(opcao);
              //tipoUsuarioGlobal = opcao;
            });
          },
          value: _categoriaSexo,
        ),
      ),
    );
  }

  returnCampoChoiceBoxIdade() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.only(
            top: 5,
            bottom:5,
            left:10,
            right: 10
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color:  Colors.black45,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<String>(
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
          items : _tipoIdade.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: ( String opcao) {
            setState(() {
              print(opcao);
              _categoriaIdade =  opcao;
              //print(opcao);
              //tipoUsuarioGlobal = opcao;
            });
          },
          value: _categoriaIdade,
        ),
      ),
    );
  }

  returnCampoChoiceBoxGraduacao() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.only(
            top: 5,
            bottom:5,
            left:10,
            right: 10
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color:  Colors.black45,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<String>(
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
          items : _tipoGraduacao.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: ( String opcao) {
            setState(() {
              print(opcao);
              _categoriaGraduacao =  opcao;
              //print(opcao);
              //tipoUsuarioGlobal = opcao;
            });
          },
          value: _categoriaGraduacao,
        ),
      ),
    );
  }

}

