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
import 'package:tcc_mobile/view/help_dano.dart';
import '../home_arbitro.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AvaliacaoDano extends StatefulWidget {
  final CombateModel combate;

  const AvaliacaoDano({ this.combate});

  @override
  _AvaliacaoDanoState createState() => _AvaliacaoDanoState();
}

class _AvaliacaoDanoState extends State<AvaliacaoDano> {
  Color baseColor = Colors.black;


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
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.help,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Future.delayed(new Duration(milliseconds: 100), () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new HelpPage()
                              ));
                        });
                      },
                    ),
                  )
                ],
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(image: AssetImage("images/fundo2_d.png"),
                        fit: BoxFit.cover)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                text: 'Dano em ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: baseColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                    '${widget.combate.nameA}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: baseColor,
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
                                  child: Text('Trivial',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Menor',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.center,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Maior',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.topRight,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 6.0,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                overlayColor: Colors.red.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                              ),
                              child: Slider(
                                  value: widget.combate.danoA.toDouble(),
                                  min: 0,
                                  activeColor: baseColor.withOpacity(0.7),
                                  inactiveColor: baseColor.withOpacity(0.3),
                                  max: 5,
                                  divisions: 5,
                                  label: getValue(widget.combate.danoA.toDouble()),
                                  onChanged: (double value) {
                                    Vibrate.feedback(FeedbackType.medium);
                                    setState(() {
                                      widget.combate.danoA = value.toInt();
                                    }
                                    );
                                  }),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Cosmetico',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Significativo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.center,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Massivo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.bottomRight,
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
                                  color: baseColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                    '${widget.combate.nameB}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: baseColor,
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
                                  child: Text('Trivial',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Menor',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.center,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Maior',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.topRight,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 6.0,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                                overlayColor: Colors.red.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                              ),
                              child: Slider(
                                  value: widget.combate.danoB.toDouble(),
                                  min: 0,
                                  activeColor: baseColor.withOpacity(1),
                                  inactiveColor: baseColor.withOpacity(0.3),
                                  max: 5,
                                  divisions: 5,
                                  label: getValue(widget.combate.danoB.toDouble()),
                                  onChanged: (double value) {
                                    Vibrate.feedback(FeedbackType.medium);
                                    widget.combate.danoB = value.toInt();
                                    setState(() {
                                      widget.combate.danoB = value.toInt();
                                    }
                                    );
                                  }),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Cosmetico',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Significativo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.center,
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 80)/6,
                                ),
                                Container(
                                  child: Text('Massivo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                        color: baseColor,
                                        fontSize: 15
                                    ),),
                                  alignment: Alignment.bottomRight,
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
                                  return confirmationDialog(controller);
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
                                  color: baseColor,
                                  fontWeight: FontWeight.w500,

                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
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

  Widget confirmationDialog(AvaliacaoBController controller) {
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
                      color: Colors.black,
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
              Container(
                margin: EdgeInsets.only(top: 10,left: 75, right: 75),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black.withOpacity(0.9),
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
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
              ),
              Container(
                padding: EdgeInsets.only(top: 20, right: 75,left: 75),
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  onPressed: () async {
                    controller.loadinging = true;
                    bool status = await controller.finaliza(widget.combate);
                    Navigator.of(context).pop();
                    if(status){
                      Navigator.pushAndRemoveUntil(
                        context,
                          MaterialPageRoute(builder: (context) => new ArbitroScreen()),
                              (Route<dynamic> route) => false
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
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: controller.loading ? SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                    ),
                  ):  Text(
                      'Finalizar avaliação',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
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

