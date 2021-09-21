import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/config/strings.dart';
import 'package:tcc_mobile/controller/avaliacao_a_controller.dart';
import 'package:tcc_mobile/model/combate_model.dart';
import 'package:tcc_mobile/view/avaliacao/avaliacao_hits_desempate.dart';

import '../home_arbitro.dart';
import 'avaliacao_dano.dart';

class AvaliacaoHits extends StatefulWidget {
  final CombateModel combateModel;

  const AvaliacaoHits({ this.combateModel});

  @override
  _AvaliacaoHitsState createState() => _AvaliacaoHitsState();
}

class _AvaliacaoHitsState extends State<AvaliacaoHits> {
  Color greenBase = Color(0xff14ff00);
  Color redBase = Color(0xffff0000);


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
                        if(widget.combateModel.hitsA == widget.combateModel.hitsB){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new AvaliacaoHitsDesempate(combateModel: widget.combateModel)));
                        }else {
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
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/fundoBra.png"),
                        fit: BoxFit.cover)
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          //color: Colors.grey,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(widget.combateModel.nameA,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text(widget.combateModel.nameB,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                  fontWeight: FontWeight.bold
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
                            padding: EdgeInsets.only(right: 15),
                            child: Material(
                              color: greenBase,
                              borderRadius:BorderRadius.only(topRight: Radius.circular(30),),
                              child: Ink(
                                child: InkWell(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),),
                                  onTap: (){
                                    Vibrate.feedback(FeedbackType.medium);
                                    setState(() {
                                      widget.combateModel.hitsA++;
                                    });
                                    controller.updateHits('_hits_a', widget.combateModel.hitsA);
                                  },
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 200),
                                    alignment: Alignment.center,
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
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width/2 * 0.3),
                            height: (MediaQuery.of(context).size.height - 300),
                            padding: EdgeInsets.only(right: 5),
                            child: Material(
                              color: redBase,
                              borderRadius:BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
                              child: Ink(
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0.8),
                                  highlightColor: Colors.white.withOpacity(0.8),
                                  borderRadius:BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
                                  onTap: (){
                                    if(widget.combateModel.hitsA>0) {
                                      Vibrate.feedback(FeedbackType.warning);
                                      setState(() {
                                        widget.combateModel.hitsA--;
                                      });
                                      controller.updateHits(
                                          '_hits_a', widget.combateModel.hitsA);
                                    }
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
                            padding: EdgeInsets.only(left: 5),
                            height: (MediaQuery.of(context).size.height - 300),
                            child: Material(
                              color: redBase,
                              borderRadius:BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),

                              child: Ink(
                                child: InkWell(
                                  splashColor: Colors.white.withOpacity(0.8),
                                  highlightColor: Colors.white.withOpacity(0.8),
                                  borderRadius:BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
                                  onTap: (){
                                    if(widget.combateModel.hitsB>0) {
                                      Vibrate.feedback(FeedbackType.warning);
                                      setState(() {
                                        widget.combateModel.hitsB--;
                                      });
                                      controller.updateHits(
                                          '_hits_b', widget.combateModel.hitsB);
                                    }
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
                            padding: EdgeInsets.only(left: 10),
                            child: Material(
                              color: greenBase,
                              borderRadius:BorderRadius.only( topLeft: Radius.circular(30),),

                              child: Ink(
                                child: InkWell(

                                  splashColor: Colors.white.withOpacity(0.8),
                                  highlightColor: Colors.white.withOpacity(0.8),
                                  borderRadius:BorderRadius.only( topLeft: Radius.circular(30),),
                                  onTap: (){
                                    Vibrate.feedback(FeedbackType.medium);
                                    setState(() {
                                      widget.combateModel.hitsB++;
                                    });
                                    controller.updateHits('_hits_b', widget.combateModel.hitsB);
                                  },
                                  child: Container(
                                    height: (MediaQuery.of(context).size.height - 200),
                                    alignment: Alignment.center,
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

