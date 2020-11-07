import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:teste_requisicao/Arbitro/Arbitro.dart';
import '../../main.dart';

String nomeAtletaPoomsae;
String equipeAtletaPoomsae;
String dbIdCompetidor;
String dbMedia;
bool flag;
double sliderA = 2.0;
double sliderB = 2.0;
double sliderC = 2.0;
double notaTecnica;

class PoomsaeB extends StatefulWidget {

  PoomsaeB(String n,e, double nt,id, m, bool f){
    nomeAtletaPoomsae = n;
    equipeAtletaPoomsae = e;
    notaTecnica = nt;
    dbIdCompetidor = id;
    dbMedia = m;
    flag = f;
  }

  @override
  _PoomsaeBState createState() => _PoomsaeBState();
}

class _PoomsaeBState extends State<PoomsaeB> {

  @override
  void initState() {
    // TODO: implement initState
    sliderA = 2.0;
    sliderB = 2.0;
    sliderC = 2.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Dezdan - Poomsae Score"),
        ),
        body: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      ColunaSlicer(),
                      ColunaDireita(),
                    ],
                  ),
                ),

              ],
            )
        )
    );
  }


  // ignore: non_constant_identifier_names
  ColunaSlicer() {
    return Container(
      width: MediaQuery.of(context).size.width*0.65,
      child: Column(
        children: <Widget>[
          WidgetDadosSuperioresEsquerdo(),
          Text("POTÊNCIA - " + sliderA.toStringAsFixed(2)),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: sliderA,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: sliderA.toStringAsFixed(2),
              onChanged: (value) {
                setState(
                      () {
                    sliderA = value;
                  },
                );
              },
            ),
          ),
          Divider(color: Colors.black,),
          Text("RITMO - " + sliderB.toStringAsFixed(2)),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: sliderB,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: sliderB.toStringAsFixed(2),
              onChanged: (value) {
                setState(
                      () {
                    sliderB = value;
                  },
                );
              },
            ),
          ),
          Divider(color: Colors.black,),
          Text("EXPRESSÃO - " + sliderC.toStringAsFixed(2)),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: sliderC,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: sliderC.toStringAsFixed(2),
              onChanged: (value) {
                setState(
                      () {
                    sliderC = value;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  WidgetDadosSuperioresEsquerdo(){
    return SizedBox(
      child: Container(
        //width: MediaQuery.of(context).size.width*.5,
        padding: EdgeInsets.fromLTRB(2, 8, 2, 16),
        child: Container(
          padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
          decoration: BoxDecoration(
            color: Color.fromRGBO(191, 191, 191, 1),
            border: Border.all(
              color: Color.fromRGBO(191, 191, 191, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: NewAutoSizeText("ATLETA: " + nomeAtletaPoomsae + "  |  EQUIPE: "+equipeAtletaPoomsae,MediaQuery.of(context).size.width*0.5,1),
        ),

      ),
    );
  }

  // ignore: non_constant_identifier_names
  ColunaDireita(){
    double media = notaTecnica+sliderA+sliderB+sliderC;
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  NewAutoSizeText("Nota Técnica: " + notaTecnica.toStringAsFixed(2)
                  +"\nNota Ritmo: " + sliderB.toStringAsFixed(2)
                  +"\nNota Potência: " +sliderA.toStringAsFixed(2)
                  +"\nNota Expressão: "+ sliderC.toStringAsFixed(2),MediaQuery.of(context).size.width*0.3,4),
                ],
              ),
            ],
          ),
          NewAutoSizeText("Nota Final: "+ media.toStringAsFixed(2),MediaQuery.of(context).size.width*0.35,1),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: RaisedButton(
              onPressed: () {
                atualizaNotas();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => new ArbitroScreen()),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.fromLTRB(0,00,0,0),
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
                    "ENVIAR NOTA",
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
    );
  }

  // ignore: non_constant_identifier_names
  NewAutoSizeText(String texto,double tamanho, int linhas){
    return Container(
      width: tamanho,
      child: AutoSizeText(
        texto,
        maxLines: linhas,
        maxFontSize: 40,
        minFontSize: 10,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.black),
      ),
    );
  }

  void atualizaNotas() {
    try {
      if(!flag) {
        final databaseReference = Firestore.instance;
        databaseReference.collection("$campeonatoGlobal-Competidores")
            .document(dbIdCompetidor)
            .updateData({
          '${valorArbitroGlobal}nt1': '${notaTecnica.toStringAsFixed(2)}',
          '${valorArbitroGlobal}np1': '${sliderA.toStringAsFixed(2)}',
          '${valorArbitroGlobal}nr1': '${sliderB.toStringAsFixed(2)}',
          '${valorArbitroGlobal}ne1': '${sliderC.toStringAsFixed(2)}',
          '${valorArbitroGlobal}ng1': '${(notaTecnica + sliderA + sliderB +
              sliderC).toStringAsFixed(2)}',
        });
        print("atualizado com sucesso AS  NOTAS");
      }else if(flag){
//        double novaMedia = ((notaTecnica + sliderA + sliderB + sliderC) + double.parse(dbMedia))/2;
//        double novaNotaPot = ((sliderA) + double.parse(dbLastNotaPot))/2;
//        double novaNotaExp = (( sliderC) + double.parse(dbLastNotaExp))/2;
//        double novaNotaTec = ((notaTecnica) + double.parse(dbLastNotaTec))/2;
//        double novaNotaRit = (( sliderB ) + double.parse(dbLastNotaRit))/2;

        final databaseReference = Firestore.instance;
        databaseReference.collection("$campeonatoGlobal-Competidores")
            .document(dbIdCompetidor)
            .updateData({
          '${valorArbitroGlobal}nt2': '${notaTecnica.toStringAsFixed(2)}',
          '${valorArbitroGlobal}np2': '${sliderA.toStringAsFixed(2)}',
          '${valorArbitroGlobal}nr2': '${sliderB.toStringAsFixed(2)}',
          '${valorArbitroGlobal}ne2': '${sliderC.toStringAsFixed(2)}',
          '${valorArbitroGlobal}ng2': '${(notaTecnica + sliderA + sliderB + sliderC).toStringAsFixed(2)}',
        });
        print("atualizado com sucesso AS  NOTAS");
      }
    } catch (e) {
      print("-------ERRO AO ATUALIZAR NOTAS------$e");
    }
  }

}
