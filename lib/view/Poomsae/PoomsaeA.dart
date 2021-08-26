import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tcc_mobile/model/combate_model.dart';

class PoomsaeA extends StatefulWidget {
  final CombateModel combateModel;

  const PoomsaeA({ this.combateModel});

  @override
  _PoomsaeAState createState() => _PoomsaeAState();
}

class _PoomsaeAState extends State<PoomsaeA> {


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
    return Scaffold(
      appBar: AppBar(

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
      ),
    );
  }
}

