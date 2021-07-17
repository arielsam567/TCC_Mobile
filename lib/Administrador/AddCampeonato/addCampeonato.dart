import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:tcc_mobile/Administrador/AdmScreen.dart';

List<String> idsExistentes = new List();
class AddCampeonato extends StatefulWidget {
  AddCampeonato(List<String> id ){
    idsExistentes = id;
  }

  @override
  _AddCampeonatoState createState() => _AddCampeonatoState();
}

class _AddCampeonatoState extends State<AddCampeonato> {
  final databaseReference = Firestore.instance;
  TextEditingController _controllerNomeCampeonato =  new TextEditingController();
  TextEditingController _controllerLocalCampeonato =  new TextEditingController();
  TextEditingController _controllerUrlImgCampeonato =  new TextEditingController();
  TextEditingController _controllerIdentificadorCampeonato =  new TextEditingController();
  TextEditingController _controllerDataCampeonato =  new MaskedTextController(mask: '00-00-0000');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dezdan - Poomsae Score'),
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
          child: AutoSizeText('Adicionar Campeonato',minFontSize: 15,maxFontSize: 30,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
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
        ),//Img Campeonato
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
            ), //VOLTAT
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  bool validador = false;
                  idsExistentes.forEach((element) {
                    if(element == _controllerIdentificadorCampeonato.text || element == 'Administrador' || element == 'Campeonatos' ){
                      validador = true;
                    }
                  });
                  if(!validador) {
                    criarCampeonato();
                    criarCampeonatoArbitro();
                    criarCampeonatoMesario();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => new AdmScreen())
                    );
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
                      "ADICIONAR",
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

  void criarCampeonato() async {
    try {
      await databaseReference.collection("Campeonatos")
          .document()
          .setData({
        'nome': '${_controllerNomeCampeonato.text}',
        'data': '${_controllerDataCampeonato.text}',
        'local': '${_controllerLocalCampeonato.text}',
        'urlImg': '${_controllerUrlImgCampeonato.text}',
        'identificador': '${_controllerIdentificadorCampeonato.text}',
      });
      print("criado com sucesso");

    } catch (e) {
      print("-------ERRO AO ADICIONAT------$e");
    }
  }

  void criarCampeonatoArbitro() async {
    try {
      for(int i=1;i<=5;i++) {
        await databaseReference.collection(
            "${_controllerIdentificadorCampeonato.text}-Arbitros")
            .document()
            .setData({
          'nome': 'ARBITRO$i',
          'senha': 'ARBITRO$i',
          'id': 'ARB$i',
          'status': false,
        });
        print("criado o $i com sucesso");
      }
    } catch (e) {
      print("-------ERRO AO ADICIONAT------$e");
    }
  }

  void criarCampeonatoMesario() async {
    try {
        await databaseReference.collection(
            "${_controllerIdentificadorCampeonato.text}-Mesario")
            .document()
            .setData({
          'nome': 'MESARIO',
          'senha': 'MESARIO',
          'status': false,
        });
    } catch (e) {
      print("-------ERRO AO ADICIONAT MESARIO------$e");
    }
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

}

