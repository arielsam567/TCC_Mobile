import 'package:flutter/material.dart';

import '../../main.dart';
import '../login_screen.dart';


class StaggerAnimation extends StatelessWidget {

  final AnimationController controller;


  StaggerAnimation({this.controller}) :
        buttonSqueeze = Tween(
          begin: 320.0,
          end: 60.0,
        ).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0, 0.05)
            )),
        buttonZoomOut = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(
            CurvedAnimation(
                curve: Interval(0.92, 1.0, curve: Curves.slowMiddle),
                parent: controller
            ));


  final Animation<double> buttonSqueeze;
  final Animation<double> buttonZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child){
    return Padding(padding: EdgeInsets.only(bottom: 50,),
      child: InkWell(
        onTap: ()  {
          nomeUsuarioGlobal = controllerNome.text;
          senhaUsuarioGlobal = controllerSenha.text;
          campeonatoGlobal = controllerEvento.text;
          consultaDocumentosLogin();
          controller.forward();
        },
        child: Hero(
          tag: "fade",
          child:         buttonZoomOut.value <= 60?
          Container(
            width: buttonSqueeze.value,
            height: 60.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: _buildInside(context),
          ) :
          Container(
            width: buttonZoomOut.value,
            height: buttonZoomOut.value,
            decoration: BoxDecoration(
                color: Colors.black54,
                shape: buttonZoomOut.value <500 ?
                BoxShape.circle : BoxShape.rectangle
            ),
          ),

        ),

      ),
    );
  }

  Widget _buildInside(BuildContext context){
    if(buttonSqueeze.value>75){
      return Text("Entrar",
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3
        ),);
    }else{
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
