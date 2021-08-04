import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../login_screen.dart';


class FormContainer extends StatefulWidget {

  @override
  FormContainerState createState() => FormContainerState();
}

class FormContainerState extends State<FormContainer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
   void initState(){
    super.initState();
    controllerSenha.text = senhaUsuarioGlobal;
    controllerNome.text = nomeUsuarioGlobal;
    controllerEvento.text = campeonatoGlobal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            returnCampoNome(),
            returnCampoSenha(),
            returnCampoCampeonato(),
          ],
        ),
      ),
    );
  }

  Widget returnCampoSenha(){
      return Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 0.5,
                )
            )
        ),
        child: TextFormField(
          onChanged: (text){
            _salvaSenha(text);
          },
          obscureText:  true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Digite sua Senha';
            }
            return null;
          },

          controller: controllerSenha,
          style: TextStyle(color: Colors.black,),
          decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.black54),
              icon: Icon(
                Icons.lock,
                color: Colors.black54,
              ),
              border: OutlineInputBorder(),
              hintText: 'Senha',
              hintStyle: TextStyle(
                  fontSize: 15
              ),
              contentPadding: EdgeInsets.only(
                top: 5,
                right: 5,
                left: 15,
                bottom: 1,
              )
          ),
        ),
      );
  }

  Widget returnCampoNome(){
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom:10,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.white24,
                width:0.5,
              )
          )
      ),
      child: TextFormField(
        onChanged: (text){
          _salvaNome(text);
        },
        controller:  controllerNome,
        validator: (value) {
          if (value.isEmpty) {
            return 'Minimo 5 caracteres';
          }
          if(value.length<5){
            return 'Minimo 5 caracteres';
          }
          return null;
        },
        style: TextStyle(color: Colors.black,),
        decoration: InputDecoration(
            labelText: 'Nome',
            labelStyle: TextStyle(color: Colors.black54),
            icon: Icon(
              Icons.person_pin,
              color: Colors.black54,
            ),
            border: OutlineInputBorder(),
            hintText: 'Nome',
            hintStyle: TextStyle(
                fontSize: 15
            ),
            contentPadding: EdgeInsets.only(
              top:5,
              right:5,
              left:15,
              bottom: 1,
            )
        ),
        //new MaskedTextController(mask: this.mask),

      ),
    );
  }

  Widget returnCampoCampeonato(){
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom:10,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.white24,
                width:0.5,
              )
          )
      ),
      child: TextFormField(
        onChanged: (text){
          _salvaCampeonato(text);
        },
        controller:  controllerEvento,
        style: TextStyle(color: Colors.black,),
        decoration: InputDecoration(
            labelText: 'Evento',
            labelStyle: TextStyle(color: Colors.black54),
            icon: Icon(
              Icons.assistant_photo,
              color: Colors.black54,
            ),
            border: OutlineInputBorder(),
            hintText: 'Evento',
            hintStyle: TextStyle(
                fontSize: 15
            ),
            contentPadding: EdgeInsets.only(
              top:5,
              right:5,
              left:15,
              bottom: 1,
            )
        ),
        //new MaskedTextController(mask: this.mask),

      ),
    );
  }

  void _salvaNome(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nomeUsuarioGlobal', dado);
    nomeUsuarioGlobal = dado;
  }

  void _salvaSenha(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('senhaUsuarioGlobal', dado);
    senhaUsuarioGlobal = dado;
  }

  void _salvaCampeonato(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('campeonatoGlobal', dado);
    campeonatoGlobal = dado;
  }

}