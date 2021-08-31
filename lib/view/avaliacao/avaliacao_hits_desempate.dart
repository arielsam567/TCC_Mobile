import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/config/strings.dart';
import 'package:tcc_mobile/controller/avaliacao_desempate_controller.dart';
import 'package:tcc_mobile/model/combate_model.dart';

import 'avaliacao_dano.dart';

class AvaliacaoHitsDesempate extends StatefulWidget {
  final CombateModel combateModel;

  const AvaliacaoHitsDesempate({ this.combateModel});

  @override
  _AvaliacaoHitsDesempateState createState() => _AvaliacaoHitsDesempateState();
}

class _AvaliacaoHitsDesempateState extends State<AvaliacaoHitsDesempate> {
  int vencedor = 3;
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
    return ChangeNotifierProvider<AvaliacaoDesempateController>(
      create: (context) => AvaliacaoDesempateController(widget.combateModel.id),
      child: Consumer<AvaliacaoDesempateController>(
          builder: (BuildContext context, AvaliacaoDesempateController controller, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                title: Text(Strings.appName),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Future.delayed(new Duration(milliseconds: 100), () {
                        if(vencedor != 3) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new AvaliacaoDano(combate: widget.combateModel)));
                        }else{
                          Fluttertoast.showToast(
                              msg: "Você deve definir um vencedor",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      });
                    },
                  )
                ],
              ),
              body: Container(
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          color: Colors.grey,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(widget.combateModel.nameA,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          color: Colors.greenAccent,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(widget.combateModel.nameB,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ],
                    ),//NOMES
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top:50.0),
                        child: Text(
                          'Escolha o vencedor no quesito Hits',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ), //Escolha um vencedor no quesito hits
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width/2 * 0.7),
                            height: (MediaQuery.of(context).size.height - 200),
                            child: Material(
                              color: vencedor == 1 ? Colors.green : Colors.grey[300],
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      vencedor = 1;
                                    });
                                    controller.updateDesempate('_desempate', vencedor);
                                  },
                                  child: Text(vencedor == 1 ? '🏆' : '😢',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: (MediaQuery.of(context).size.width/2 * 0.7),
                            height: (MediaQuery.of(context).size.height - 200),
                            child: Material(
                              color: vencedor == 2 ? Colors.green : Colors.grey[300],
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      vencedor = 2;
                                    });
                                    controller.updateDesempate('_desempate', vencedor);
                                  },
                                  child: Text(vencedor == 2 ? '🏆' : '😢',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],),
                    ),
                  ],
                ),
              ), //center
            );
          }),
    );
  }
}

