import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_mobile/main.dart';

import 'PoomsaeB.dart';

String nomeAtletaPoomsae;
String equipeAtletaPoomsae;
String dbIdCompetidor;
String dbLastMedia;
String dbLastNotaRit;
String dbLastNotaTec;
String dbLastNotaPot;
String dbLastNotaExp;
bool flag;

double sliderA = 2.0;
double sliderB = 2.0;
double sliderC = 2.0;
double notaTecnica = 4.0;


class PoomsaeA extends StatefulWidget {

  PoomsaeA(String n,e,id,m,bool f ){
    nomeAtletaPoomsae = n;
    equipeAtletaPoomsae = e;
    dbIdCompetidor = id;
    dbLastMedia = m;
    flag = f;
  }


  @override
  _PoomsaeAState createState() => _PoomsaeAState();
}

class _PoomsaeAState extends State<PoomsaeA> {
  double height;
  double width;
  bool flagMovel = false;
  Offset offsetB;
  Offset offsetA;

  @override
  void initState() {
    super.initState();
    sliderA = 2.0;
    sliderB = 2.0;
    sliderC = 2.0;
    notaTecnica = 4.0;
    setPosicaoBotao();
  }

  setPosicaoBotao(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    offsetA = Offset(10,MediaQuery.of(context).size.height/4);
    offsetB = Offset(MediaQuery.of(context).size.height*0.5,MediaQuery.of(context).size.height/4);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Dezdan - Poomsae Score"),
          actions: <Widget>[
            IconButton(
              icon: flagMovel ? Icon(Icons.lock_open) :  Icon(Icons.lock_outline) ,
              onPressed: (){
                setState(() {
                  flagMovel = !flagMovel;
                });
              },
            ),
            IconButton(
              padding: EdgeInsets.fromLTRB(8, 8, 98, 8),
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => new PoomsaeB(nomeAtletaPoomsae,
                      equipeAtletaPoomsae,
                      notaTecnica,
                      dbIdCompetidor,
                      dbLastMedia,
                      flag)),
                );
              },
            ),
          ],
        ),
        body: Center(
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/fundoVerde.jpeg"),
                              fit: BoxFit.cover)
                      ),
                      width: MediaQuery.of(context).size.width,
                     // color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          WidgetDadosSuperioresEsquerdo(),
                          WidgetNotaTecnica(),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: offsetA.dx,
                  top: offsetA.dy,
                  child: GestureDetector(
                      onPanUpdate: (details) {
                        if(flagMovel){
                          setState(() {
                            offsetA = Offset(offsetA.dx + details.delta.dx, offsetA.dy + details.delta.dy);
                            print(Offset(offsetA.dx + details.delta.dx, offsetA.dy + details.delta.dy));
                          });
                        }},
                      child: RaisedButton(
                        onPressed: () {
                          if(notaTecnica>=0.3){
                            notaTecnica = notaTecnica - 0.3;
                            setState(() {
                              // ignore: unnecessary_statements
                              notaTecnica;
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color.fromRGBO(255,50,50,1), Color.fromRGBO(255,90,90,1)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.4, minHeight: MediaQuery.of(context).size.height*0.2),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "- 0.3",
                              minFontSize: 10,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30
                              ),
                            ),
                          ),
                        ),
                      )),),
                Positioned(
                  left: offsetB.dx,
                  top: offsetB.dy,
                  child: GestureDetector(
                      onPanUpdate: (details) {
                        if(flagMovel){
                          setState(() {
                            offsetB = Offset(offsetB.dx + details.delta.dx, offsetB.dy + details.delta.dy);
                          });
                        }},
                      child: RaisedButton(
                        onPressed: () {
                          if(notaTecnica>=0.1){
                            notaTecnica = notaTecnica - 0.1;
                            setState(() {
                              // ignore: unnecessary_statements
                              notaTecnica;
                            });
                          }
                        },
                        onLongPress: (){

                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color.fromRGBO(255,50,50,1), Color.fromRGBO(255,90,90,1)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.4, minHeight: MediaQuery.of(context).size.height*0.2),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "- 0.1",
                              minFontSize: 10,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30
                              ),
                            ),
                          ),
                        ),
                      )),)
              ],
            )
        )
    );
  }

  // ignore: non_constant_identifier_names
  WidgetDadosSuperioresEsquerdo(){
    return SizedBox(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*0.94 ,
              height: MediaQuery.of(context).size.height*0.1,
              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
              decoration: BoxDecoration(
                color: Color.fromRGBO(191, 191, 191, 1),
                border: Border.all(
                  color: Color.fromRGBO(191, 191, 191, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: NewAutoSizeText("ÁRBRITO: " + nomeUsuarioGlobal.toUpperCase()+"  |  ATLETA: " + nomeAtletaPoomsae.toUpperCase() + "  |  EQUIPE: "+equipeAtletaPoomsae.toUpperCase(),MediaQuery.of(context).size.width*0.95),
            ),

          ],
        ),

      ),
    );
  }

  // ignore: non_constant_identifier_names
  WidgetNotaTecnica() {
    return Container(
      padding: EdgeInsets.fromLTRB(8,16,8,16),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if(notaTecnica<=3.7){
                notaTecnica = notaTecnica + 0.3;
                setState(() {
                  // ignore: unnecessary_statements
                  notaTecnica;
                });
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
                  "+ 0.3",
                  maxLines: 1,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(flagMovel==true){
                flagMovel = false;
              }else{
                flagMovel= true;
              }
              setState(() {
              });
            },
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(4, 8, 4, 0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: new LinearGradient(
                        colors: [
                          const Color.fromRGBO(255, 255, 255, 1.0),
                          const Color.fromRGBO(191, 191, 191, 1.0),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  alignment: Alignment.topCenter,
                  width:MediaQuery.of(context).size.width*0.3 ,
                  child: AutoSizeText("NOTA TÉCNICA:",maxLines:1 ,minFontSize: 8, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
              Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: new LinearGradient(
                        colors: [
                          const Color.fromRGBO(255, 255, 255, 1.0),
                          const Color.fromRGBO(191, 191, 191, 1.0),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  alignment: Alignment.topCenter,
                  width:MediaQuery.of(context).size.width*0.3 ,
                  child: AutoSizeText(notaTecnica.toStringAsFixed(2),maxLines: 1,minFontSize: 8, style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),)),
            ],),
          ),
          RaisedButton(
            onPressed: () {
              if(notaTecnica<=3.9){
                notaTecnica = notaTecnica + 0.1;
                setState(() {
                  // ignore: unnecessary_statements
                  notaTecnica;
                });
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
                  "+ 0.1",
                  minFontSize: 10,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  NewAutoSizeText(String texto,double tamanho){
    return Container(
      width: tamanho,
      child: AutoSizeText(
        texto,
        maxLines: 1,
        maxFontSize: 70,
        minFontSize: 10,
        style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold,color: Colors.black),
      ),
    );
  }

}

