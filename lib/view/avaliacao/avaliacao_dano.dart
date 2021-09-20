import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/config/strings.dart';
import 'package:tcc_mobile/controller/avaliacao_b_controller.dart';
import 'package:tcc_mobile/model/combate_model.dart';

import '../home_arbitro.dart';


class AvaliacaoDano extends StatefulWidget {
  final CombateModel combate;

  const AvaliacaoDano({ this.combate});

  @override
  _AvaliacaoDanoState createState() => _AvaliacaoDanoState();
}

class _AvaliacaoDanoState extends State<AvaliacaoDano> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AvaliacaoBController>(
      create: (context) => AvaliacaoBController(widget.combate.id),
      child: Consumer<AvaliacaoBController>(
          builder: (BuildContext context, AvaliacaoBController controller, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                title: Text(Strings.appName),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Dano em ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                  '${widget.combate.nameA}',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('Trivial'),
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Cosmetico'),
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Menor'),
                                alignment: Alignment.center,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Significativo'),
                                alignment: Alignment.center,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Maior'),
                                alignment: Alignment.topRight,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Massivo'),
                                alignment: Alignment.bottomRight,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Slider(
                              value: widget.combate.danoA.toDouble(),
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: getValue(widget.combate.danoA.toDouble()),
                              onChanged: (double value) {
                                setState(() {
                                  widget.combate.danoA = value.toInt();
                                }
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //child: Text('Trivial'),
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Cosmetico'),
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Menor'),
                                alignment: Alignment.center,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Significativo'),
                                alignment: Alignment.center,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Maior'),
                                alignment: Alignment.topRight,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Massivo'),
                                alignment: Alignment.bottomRight,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 60, 40, 0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: 'Dano em ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                  '${widget.combate.nameB}',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text('Trivial'),
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Cosmetico'),
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Menor'),
                                alignment: Alignment.center,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Significativo'),
                                alignment: Alignment.center,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Maior'),
                                alignment: Alignment.topRight,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Massivo'),
                                alignment: Alignment.bottomRight,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Slider(
                              value: widget.combate.danoB.toDouble(),
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: getValue(widget.combate.danoB.toDouble()),
                              onChanged: (double value) {
                                widget.combate.danoB = value.toInt();
                                setState(() {
                                  widget.combate.danoB = value.toInt();
                                }
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //child: Text('Trivial'),
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Cosmetico'),
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Menor'),
                                alignment: Alignment.center,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Significativo'),
                                alignment: Alignment.center,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                //child: Text('Maior'),
                                alignment: Alignment.topRight,
                                color: Colors.deepOrange,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                              Container(
                                child: Text('Massivo'),
                                alignment: Alignment.bottomRight,
                                color: Colors.white,
                                width: (MediaQuery.of(context).size.width - 80)/6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 50, right: 100, left: 100),
                      child: FlatButton(
                        highlightColor: Colors.blue.withOpacity(0.1),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return cancelDialog(controller);
                              });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.all(0.0),
                        color: Colors.white,
                        minWidth: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width - (30 * 2 + 16 * 2 + 20 * 2 + 25),
                          child: AutoSizeText(
                            'Finalizar avaliação',
                            maxLines: 1,
                            minFontSize: 8,
                            maxFontSize: 16,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ), //center
            );
          }),
    );
  }

  getValue(double valor) {
    if(valor == 0){
      return 'TRIVIAL';
    }else if(valor == 1){
      return 'COSMÉTICO';
    }else if(valor == 2){
      return 'MENOR';
    }else if(valor == 3){
      return 'SIGNIFICATIVO';
    }else if(valor == 4){
      return 'MAIOR';
    }else if(valor == 5){
      return 'MASSIVO';
    }



  }


  Widget cancelDialog(AvaliacaoBController controller) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 330,
          width: 400,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, right: 20, left: 20, bottom: 20),
                child: AutoSizeText(
                  'Finalizar avaliação',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 5, 40, 20),
                child: AutoSizeText(
                  'Você realmente deseja finalizar esta avaliação?',
                  maxLines: 2,
                  minFontSize: 8,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.pink,
                  padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                  child: AutoSizeText(
                    'Voltar',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20,),
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.pink,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  onPressed: () async {
                    bool status = await controller.finaliza(widget.combate);
                    Navigator.of(context).pop();
                    if(status){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => new ArbitroScreen())
                      );
                      Fluttertoast.showToast(
                          msg: "Combate avaliado com sucesso",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      //Navigator.of(context).pop();

                    }else{
                      return  Fluttertoast.showToast(
                          msg: "Ops, ocorreu algum erro, tente novamente!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                  child: Text(
                    'Finalizar avaliação',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          //height: 300,
        ),
      ),
    );
  }

}

