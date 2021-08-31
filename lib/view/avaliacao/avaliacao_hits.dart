import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/config/strings.dart';
import 'package:tcc_mobile/controller/avaliacao_a_controller.dart';
import 'package:tcc_mobile/model/combate_model.dart';
import 'package:tcc_mobile/view/avaliacao/avaliacao_hits_desempate.dart';

import '../Arbitro.dart';
import 'avaliacao_dano.dart';

class AvaliacaoHits extends StatefulWidget {
  final CombateModel combateModel;

  const AvaliacaoHits({ this.combateModel});

  @override
  _AvaliacaoHitsState createState() => _AvaliacaoHitsState();
}

class _AvaliacaoHitsState extends State<AvaliacaoHits> {


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
    return ChangeNotifierProvider<AvaliacaoAController>(
      create: (context) => AvaliacaoAController(widget.combateModel.id),
      child: Consumer<AvaliacaoAController>(
          builder: (BuildContext context, AvaliacaoAController controller, _) {
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
                        print(widget.combateModel.hitsA);
                        print(widget.combateModel.hitsB);
                        if(widget.combateModel.hitsA == widget.combateModel.hitsB){
                          print(1);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new AvaliacaoHitsDesempate(combateModel: widget.combateModel)));
                        }else {
                          print(1111);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new AvaliacaoDano(combate: widget.combateModel)));
                        }
                      });
                    },
                  )
                ],
                leading:
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Future.delayed(new Duration(milliseconds: 100), () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => new ArbitroScreen()));

                    });
                  },
                ),

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
                          'HITS',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ), //HITS
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width/2 * 0.7),
                            height: (MediaQuery.of(context).size.height - 200),
                            child: Material(
                              color: Colors.green,
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.combateModel.hitsA++;
                                    });
                                    controller.updateHits('_hits_a', widget.combateModel.hitsA);
                                  },
                                  child: Text(widget.combateModel.hitsA.toString(),
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
                            width: (MediaQuery.of(context).size.width/2 * 0.3),
                            height: (MediaQuery.of(context).size.height - 300),
                            child: Material(
                              color: Colors.red,
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.combateModel.hitsA--;
                                    });
                                    controller.updateHits('_hits_a', widget.combateModel.hitsA);
                                  },
                                  child: Text('-1',
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
                            width: (MediaQuery.of(context).size.width/2 * 0.3),
                            height: (MediaQuery.of(context).size.height - 300),
                            child: Material(
                              color: Colors.red,
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.combateModel.hitsB--;
                                    });
                                    controller.updateHits('_hits_b', widget.combateModel.hitsB);
                                  },
                                  child: Text('-1',
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
                              color: Colors.green,
                              child: Ink(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      widget.combateModel.hitsB++;
                                    });
                                    controller.updateHits('_hits_b', widget.combateModel.hitsB);
                                  },
                                  child: Text(widget.combateModel.hitsB.toString(),
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

