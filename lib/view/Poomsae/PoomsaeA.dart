import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text(widget.combateModel.nameA)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              color: Colors.grey,
            ),

          ],
        ),
      ),
    );
  }
}

