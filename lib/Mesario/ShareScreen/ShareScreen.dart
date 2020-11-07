import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

String  nomeCompetidor;
String  idCompetidor;
String  equipeCompetidor;
String identificadorCampeonato = campeonatoGlobal;
class ShareScreen extends StatefulWidget {

  ShareScreen(String nome,equipe, id) {
    nomeCompetidor = nome;
    idCompetidor = id;
    equipeCompetidor = equipe;
  }

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen>  with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  String _notaFinalAtual = '';
  List<String> _arb = ['','','','','',''];
  String _n1arb1 = '', _n2arb1 ='',_n3arb1 = '', _n4arb1 ='';
  String _n1arb2 = '', _n2arb2 ='',_n3arb2 = '', _n4arb2 ='';
  String _n1arb3 = '', _n2arb3 ='',_n3arb3 = '', _n4arb3 ='';
  String _n1arb4 = '', _n2arb4 ='',_n3arb4 = '', _n4arb4 ='';
  String _n1arb5 = '', _n2arb5 ='',_n3arb5 = '', _n4arb5 ='';
  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    consultaDocumentosCompetidores();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.linear);

    animation =
        ColorTween(begin: Colors.black, end: Colors.red).animate(curve);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08,),
          child: AppBar(
            title: Text('Dezdan - Poomsae Score'),
          ),
        ),
        body:Container(
          color: Colors.black,
          padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width*0.5,
                color: Colors.amber,
                child: CampoEsquerda(),),
              SizedBox(width: MediaQuery.of(context).size.width*0.01),
              Container(
                width: MediaQuery.of(context).size.width*0.47,
                color: Colors.black,
                child: CampoDireita(),),
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  CampoEsquerda(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/lutadorBlue.png",
                width: MediaQuery.of(context).size.width*0.1,
                fit: BoxFit.contain),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: AutoSizeText(
                '$nomeCompetidor',
                maxLines: 1,
                minFontSize: 10,
                maxFontSize: 50,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 500),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return new Container(
                  child: AutoSizeText(
                    '$_notaFinalAtual',
                    maxLines: 1,
                    minFontSize: 100,
                    maxFontSize: 150,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 500,color: animation.value),
                  ),
                );
              }),

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              padding: EdgeInsets.fromLTRB(0, 4, 0, 16),
              child:
              Align(
                alignment: Alignment.bottomCenter,
                child: AutoSizeText(
                  equipeCompetidor,
                  maxLines: 1,
                  minFontSize: 20,
                  maxFontSize: 40,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 500),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.01),
            Image.asset("images/bolaPoomsae.png",
                width: MediaQuery.of(context).size.width*0.08,
                fit: BoxFit.contain),
          ],
        ),
      ],);
  }

  // ignore: non_constant_identifier_names
  CampoDireita(){
    try {
      return Padding(
        padding: EdgeInsets.all(4),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(child: Image.asset("images/bolaPoomsae.png",
                    width: MediaQuery.of(context).size.width*0.06,
                    fit: BoxFit.contain),),

                Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 2, 0),
                  width: MediaQuery.of(context).size.width*0.38,
                  child: AutoSizeText(
                    'Dezdan - Poomsae Score',
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 100,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.yellowAccent),
                  ),
                ),
              ],
            ),
            Table(
                border: TableBorder.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid),
                children: [
                  TableRow(children: [
                    TableCell(child: Center(child: Text(' '))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: Text('JUIZ 1',textAlign: TextAlign.center,))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: Text('JUIZ 2',textAlign: TextAlign.center,)),),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: Text('JUIZ 3',textAlign: TextAlign.center,))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: Text('JUIZ 4',textAlign: TextAlign.center,))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: Text('JUIZ 5',textAlign: TextAlign.center,))),
                  ]),
                  TableRow(decoration: new BoxDecoration(
                      color: Colors.blueGrey[100]
                  ),children: [
                    TableCell(child: Container(color:Colors.black ,child: Text('black '))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: returnNomeJuizes('${_arb[0]}'))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: returnNomeJuizes('${_arb[1]}')),),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: returnNomeJuizes('${_arb[2]}'))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: returnNomeJuizes('${_arb[3]}'))),
                    TableCell(child: Container(color: Colors.blueGrey[100],child: returnNomeJuizes('${_arb[4]}'))),
                  ]),
                  TableRow(decoration: new BoxDecoration(
                      color: Colors.white
                  ),children: [
                    TableCell(child: Container(color: Colors.blue[100], child: returnAutoSize('TÉCNICA', 'Peso 4,0'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n1arb1'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n1arb2'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n1arb3'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n1arb4'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n1arb5'))),
                  ]),
                  TableRow(decoration: new BoxDecoration(
                      color: Colors.white
                  ),children: [
                    TableCell(child: Container(color: Colors.blue[100],
                        child: returnAutoSize('POTÊNCIA', 'Peso 2,0'))),
                    TableCell(child: Container(color: Colors.white,child: returnText('$_n2arb1'))),
                    TableCell(child: Container(color: Colors.white, child: returnText('$_n2arb2'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n2arb3'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n2arb4'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n2arb5'))),
                  ]),
                  TableRow(decoration: new BoxDecoration(
                      color: Colors.white
                  ),children: [
                    TableCell(child: Container(color: Colors.blue[100],
                        child: returnAutoSize('RITMO', 'Peso 2,0'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n3arb1'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n3arb2'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n3arb3'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n3arb4'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n3arb5'))),
                  ]),
                  TableRow(decoration: new BoxDecoration(
                      color: Colors.white
                  ),children: [
                    TableCell(child: Container(color: Colors.blue[100],
                        child: returnAutoSize('EXPRESSÃO', 'Peso 2,0'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n4arb1'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n4arb2'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n4arb3'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n4arb4'))),
                    TableCell(child: Container(color: Colors.white, child:returnText('$_n4arb5'))),
                  ]),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0,8,4,4),
                  child: RaisedButton(
                    onPressed: () {
                      limparCampos();
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
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.15, minHeight: MediaQuery.of(context).size.height*0.13),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "LIMPAR",
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
                  padding:  const EdgeInsets.fromLTRB(4.0,8,4,4),
                  child: RaisedButton(
                    onPressed: () {
                      consultaNotaCompetidor(idCompetidor);
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
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.2, minHeight: MediaQuery.of(context).size.height*0.13),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "CALCULAR",
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
              ],)
          ],
        ),
      );
    }catch(e){
      print(e);
    }
  }

  returnAutoSize(String t,s){
    return Column(
      children: <Widget>[
        Text(
          t,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),
        ),
        Text(
          s,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  returnText(String d){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: Text(
        '$d',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
      ),
    );
  }

  consultaDocumentosCompetidores() async {
    try {
      final databaseReference = Firestore.instance;
      _arb = new List();
      databaseReference.collection("$identificadorCampeonato-Arbitros")
          .orderBy('id')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          _arb.add('${f.data['nome'].toString()}');
        });
        setState(() {
          // ignore: unnecessary_statements
          _arb;
        });
      });
    }catch(e){
      print(e);
    }
  }

  consultaNotaCompetidor(String id) async {
    controller.forward();
    int contador = 0;
    double maiorNota = 0, menorNota = 10;

    double notaGeral = 0 ;
    Firestore.instance.collection('$identificadorCampeonato-Competidores').document('$id').get().then((docSnap) {
      if(docSnap['ARB1np1'] != '0.00') {
        double novaMedia;
        double novaNotaPot;
        double novaNotaExp;
        double novaNotaTec;
        double novaNotaRit;
        if(docSnap['ARB1np2'] != '0.00'){
          novaMedia = (double.parse(docSnap['ARB1ng1'])+ double.parse(docSnap['ARB1ng2']))/2;
          novaNotaPot =  (double.parse(docSnap['ARB1np1'])+ double.parse(docSnap['ARB1np2']))/2;
          novaNotaExp =  (double.parse(docSnap['ARB1ne1'])+ double.parse(docSnap['ARB1ne2']))/2;
          novaNotaTec =  (double.parse(docSnap['ARB1nt1'])+ double.parse(docSnap['ARB1nt2']))/2;
          novaNotaRit =  (double.parse(docSnap['ARB1nr1'])+ double.parse(docSnap['ARB1nr2']))/2;
        }else{
          novaMedia = (double.parse(docSnap['ARB1ng1']));
          novaNotaPot =  (double.parse(docSnap['ARB1np1']));
          novaNotaExp =  (double.parse(docSnap['ARB1ne1']));
          novaNotaTec =  (double.parse(docSnap['ARB1nt1']));
          novaNotaRit =  (double.parse(docSnap['ARB1nr1']));
        }
        _n1arb1 = "$novaNotaTec";
        _n2arb1 = "$novaNotaPot";
        _n3arb1 = "$novaNotaRit";
        _n4arb1 = "$novaNotaExp";
        if(novaMedia >= maiorNota){
          maiorNota =novaMedia;
        }
        if(novaMedia <= menorNota){
          menorNota = novaMedia;
        }
        notaGeral = notaGeral + novaMedia;
        contador ++;
      }

      if(docSnap['ARB2np1'] != '0.00') {
        double novaMedia;
        double novaNotaPot;
        double novaNotaExp;
        double novaNotaTec;
        double novaNotaRit;
        if(docSnap['ARB2np2'] != '0.00'){
          novaMedia = (double.parse(docSnap['ARB2ng1'])+ double.parse(docSnap['ARB2ng2']))/2;
          novaNotaPot =  (double.parse(docSnap['ARB2np1'])+ double.parse(docSnap['ARB2np2']))/2;
          novaNotaExp =  (double.parse(docSnap['ARB2ne1'])+ double.parse(docSnap['ARB2ne2']))/2;
          novaNotaTec =  (double.parse(docSnap['ARB2nt1'])+ double.parse(docSnap['ARB2nt2']))/2;
          novaNotaRit =  (double.parse(docSnap['ARB2nr1'])+ double.parse(docSnap['ARB2nr2']))/2;
        }else{
          novaMedia = (double.parse(docSnap['ARB2ng1']));
          novaNotaPot =  (double.parse(docSnap['ARB2np1']));
          novaNotaExp =  (double.parse(docSnap['ARB2ne1']));
          novaNotaTec =  (double.parse(docSnap['ARB2nt1']));
          novaNotaRit =  (double.parse(docSnap['ARB2nr1']));
        }
        _n1arb2 = "$novaNotaTec";
        _n2arb2 = "$novaNotaPot";
        _n3arb2 = "$novaNotaRit";
        _n4arb2 = "$novaNotaExp";
        if(novaMedia>= maiorNota){
          maiorNota = novaMedia;
        }
        if(novaMedia <= menorNota){
          menorNota = novaMedia;
        }
        notaGeral = notaGeral + novaMedia;
        contador ++;
      }

      if(docSnap['ARB3np1'] != '0.00') {
        double novaMedia;
        double novaNotaPot;
        double novaNotaExp;
        double novaNotaTec;
        double novaNotaRit;
        if(docSnap['ARB2np2'] != '0.00'){
          novaMedia =    (double.parse(docSnap['ARB3ng1'])+ double.parse(docSnap['ARB3ng2']))/2;
          novaNotaPot =  (double.parse(docSnap['ARB3np1'])+ double.parse(docSnap['ARB3np2']))/2;
          novaNotaExp =  (double.parse(docSnap['ARB3ne1'])+ double.parse(docSnap['ARB3ne2']))/2;
          novaNotaTec =  (double.parse(docSnap['ARB3nt1'])+ double.parse(docSnap['ARB3nt2']))/2;
          novaNotaRit =  (double.parse(docSnap['ARB3nr1'])+ double.parse(docSnap['ARB3nr2']))/2;
        }else{
          novaMedia = (double.parse(docSnap['ARB3ng1']));
          novaNotaPot =  (double.parse(docSnap['ARB3np1']));
          novaNotaExp =  (double.parse(docSnap['ARB3ne1']));
          novaNotaTec =  (double.parse(docSnap['ARB3nt1']));
          novaNotaRit =  (double.parse(docSnap['ARB3nr1']));
        }
        _n1arb3 = '$novaNotaTec';
        _n2arb3 = "$novaNotaPot";
        _n3arb3 = "$novaNotaRit";
        _n4arb3 = "$novaNotaExp";
        if(novaMedia >= maiorNota){
          maiorNota = novaMedia;
        }
        if(novaMedia <= menorNota){
          menorNota = novaMedia;
        }
        notaGeral = notaGeral + novaMedia;
        contador ++;
      }

      if(docSnap['ARB4np1'] != '0.00') {
        double novaMedia;
        double novaNotaPot;
        double novaNotaExp;
        double novaNotaTec;
        double novaNotaRit;
        if(docSnap['ARB4np2'] != '0.00'){
          novaMedia = (double.parse(docSnap['ARB4ng1'])+ double.parse(docSnap['ARB4ng2']))/2;
          novaNotaPot =  (double.parse(docSnap['ARB4np1'])+ double.parse(docSnap['ARB4np2']))/2;
          novaNotaExp =  (double.parse(docSnap['ARB4ne1'])+ double.parse(docSnap['ARB4ne2']))/2;
          novaNotaTec =  (double.parse(docSnap['ARB4nt1'])+ double.parse(docSnap['ARB4nt2']))/2;
          novaNotaRit =  (double.parse(docSnap['ARB4nr1'])+ double.parse(docSnap['ARB4nr2']))/2;
        }else{
          novaMedia =    (double.parse(docSnap['ARB4ng1']));
          novaNotaPot =  (double.parse(docSnap['ARB4np1']));
          novaNotaExp =  (double.parse(docSnap['ARB4ne1']));
          novaNotaTec =  (double.parse(docSnap['ARB4nt1']));
          novaNotaRit =  (double.parse(docSnap['ARB4nr1']));
        }
        _n1arb4 = "$novaNotaTec";
        _n2arb4 = "$novaNotaPot";
        _n3arb4 = "$novaNotaRit";
        _n4arb4 = "$novaNotaExp";
        if(novaMedia >= maiorNota){
          maiorNota = novaMedia;
        }
        if(novaMedia<= menorNota){
          menorNota = novaMedia;
        }
        notaGeral = notaGeral + novaMedia;
        contador ++;
      }

      if(docSnap['ARB5np1'] != '0.00') {
        double novaMedia;
        double novaNotaPot;
        double novaNotaExp;
        double novaNotaTec;
        double novaNotaRit;
        if(docSnap['ARB5np2'] != '0.00'){
          novaMedia =    (double.parse(docSnap['ARB5ng1'])+ double.parse(docSnap['ARB5ng2']))/2;
          novaNotaPot =  (double.parse(docSnap['ARB5np1'])+ double.parse(docSnap['ARB5np2']))/2;
          novaNotaExp =  (double.parse(docSnap['ARB5ne1'])+ double.parse(docSnap['ARB5ne2']))/2;
          novaNotaTec =  (double.parse(docSnap['ARB5nt1'])+ double.parse(docSnap['ARB5nt2']))/2;
          novaNotaRit =  (double.parse(docSnap['ARB5nr1'])+ double.parse(docSnap['ARB5nr2']))/2;
        }else{
          novaMedia =    (double.parse(docSnap['ARB5ng1']));
          novaNotaPot =  (double.parse(docSnap['ARB5np1']));
          novaNotaExp =  (double.parse(docSnap['ARB5ne1']));
          novaNotaTec =  (double.parse(docSnap['ARB5nt1']));
          novaNotaRit =  (double.parse(docSnap['ARB5nr1']));
        }
        _n1arb5 = "$novaNotaTec";
        _n2arb5 = "$novaNotaPot";
        _n3arb5 = "$novaNotaRit";
        _n4arb5 = "$novaNotaExp";
        if(novaMedia >= maiorNota){
          maiorNota = novaMedia;
        }
        if(novaMedia <= menorNota){
          menorNota = novaMedia;
        }
        notaGeral = notaGeral + novaMedia;
        contador ++;
      }

      if(contador == 5 ){
        notaGeral = (notaGeral - menorNota) - maiorNota;
        _notaFinalAtual = ('${(notaGeral/3).toStringAsFixed(2)}');
      }else{
        _notaFinalAtual = ('${(notaGeral/contador).toStringAsFixed(2)}');
        print(notaGeral);
        print(contador);}

      setState(() {
        _notaFinalAtual;
        _n1arb1;_n2arb1;_n3arb1;_n4arb1;
        _n1arb2; _n2arb2;_n3arb2; _n4arb2;
        _n1arb3; _n2arb3;_n3arb3; _n4arb3;
        _n1arb4; _n2arb4;_n3arb4; _n4arb4;
        _n1arb5; _n2arb5;_n3arb5; _n4arb5;
      });

  });
  }

  returnNomeJuizes(String nome){
    return AutoSizeText(
      '$nome',
      maxLines: 1,
      minFontSize: 2,
      maxFontSize: 15,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 500),
    );
  }

  limparCampos() {
    setState(() {
      _notaFinalAtual = '';
      _n1arb1 = '';
      _n2arb1 ='';
      _n3arb1 = '';
      _n4arb1 ='';
      _n1arb2 = ''; _n2arb2 ='';_n3arb2 = ''; _n4arb2 ='';
      _n1arb3 = ''; _n2arb3 ='';_n3arb3 = ''; _n4arb3 ='';
      _n1arb4 = ''; _n2arb4 ='';_n3arb4 = ''; _n4arb4 ='';
      _n1arb5 = ''; _n2arb5 ='';_n3arb5 = ''; _n4arb5 ='';
    });
  }

}
