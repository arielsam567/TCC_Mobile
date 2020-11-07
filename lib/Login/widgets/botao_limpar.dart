import 'package:flutter/material.dart';
import '../login_screen.dart';


class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(
        top: 100,
        bottom: 10
      ),
      onPressed: (){
        controllerSenha.text = '';
        controllerNome.text = '';
      },
      child: Text(
        "LIMPAR",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
