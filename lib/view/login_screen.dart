import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/config/config.dart';
import 'package:tcc_mobile/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'home_arbitro.dart';



class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  String avisoErro = '';
  bool loading = false;
  UserModel user = new UserModel.start();
  TextEditingController controllerNome =  new TextEditingController();
  TextEditingController controllerSenha=  new TextEditingController();
  TextEditingController controllerEvento=  new TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/fundo2.png"),
                  fit: BoxFit.cover)
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 0),
                        child: Image.asset("images/iconW.png",
                            width: 160,
                            fit: BoxFit.contain),
                      ),
                      AlertDialog(
                        insetPadding: EdgeInsets.fromLTRB(0,15,0,0),
                        contentPadding: EdgeInsets.fromLTRB(1, 20, 5, 20),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children : <Widget>[
                            Expanded(
                              child: formContainer(),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: FlatButton(
                            color: Colors.black,
                            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () async {
                              _registerOnFirebase();
                              await pressButtonToLogin();
                            },
                            child: loading ? Container(
                              width: MediaQuery.of(context).size.width-80,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ) :  Container(
                              width: MediaQuery.of(context).size.width-80,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Text('Acessar',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontSize: 20
                                ),),
                            )
                        ),
                      ),
                      FlatButton(
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
                      )
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  wppIcon(),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child:Material(
                        // needed
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _launchURL("https://www.instagram.com/wickedbotz/"), // needed
                          child: Image.asset(
                            "images/instagram.png",
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child:Material(
                        // needed
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _launchURL("https://www.facebook.com/wickedbotz"), // needed
                          child: Image.asset(
                            "images/facebook.png",
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ],
              ),
            ],
          )
      ),

    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _registerOnFirebase();
    super.initState();
    controllerSenha.text = userGlobal.password;
    controllerNome.text = userGlobal.name;
    controllerEvento.text = userGlobal.campId;
  }

  void _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _registerOnFirebase() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.subscribeToTopic(controllerEvento.text);
  }


  Widget wppIcon() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Material(
        // needed
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL("https://api.whatsapp.com/send?phone=5547988617240&"
              "text=Olá, estou entrando em contato através do app JudgeBotz"), // needed
          child: Image.asset(
            "images/whatsapp.png",
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),);
  }



  Future<bool> consultaDocumentosLogin() async {
    final databaseReference = Firestore.instance;
    bool status;
    await databaseReference.collection("${userGlobal.campId}${Config.arbitro}").getDocuments().then((
        QuerySnapshot snapshot) {
      if(snapshot.documents.isNotEmpty) {
        snapshot.documents.forEach((f) {
          if(f.documentID != 'qtd') {
            if (f.data['fechado'] == false) {
              String auxName = '${f.data['nome']}';
              user.name = auxName;
              user.password = '${f.data['senha']}';
              user.userId = '${f.data['id']}';
              if (auxName == controllerNome.text && user.password == controllerSenha.text) {
                user.name = auxName;
                user.password = '${f.data['senha']}';
                user.userId = '${f.data['id']}';
                userGlobal.userId = user.userId;
                status = true;
              }else{
                avisoErro = 'Verifique seus dados e tente novamente';
              }
            } else {
              avisoErro = 'Este campeonato foi fechado';
              status =  false;
            }
          }
        });
      }
      else{
        avisoErro = 'Opss, algum erro!';
        status =  false;
      }
    });
    return status;
  }


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        textInputAction: TextInputAction.next,
        onChanged: (text){
          _savePassword(text);
        },
        obscureText:  _passwordVisible,
        validator: (value) {
          if (value.isEmpty) {
            return 'Digite sua Senha';
          }
          return null;
        },

        controller: controllerSenha,
        style: TextStyle(color: Colors.black,),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              !_passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          labelText: 'Senha',
          labelStyle: TextStyle(color: Colors.black54),
          icon: Icon(
            Icons.lock,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(),
          hintText: 'Senha',
          hintStyle: TextStyle(fontSize: 15),
          contentPadding: EdgeInsets.only(
            top: 5,
            right: 5,
            left: 15,
            bottom: 1,
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
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
        textInputAction: TextInputAction.next,
        onChanged: (text){
          _saveName(text);
        },
        controller:  controllerNome,
        validator: (value) {
          if (value.isEmpty) {
            return 'Informe o nome';
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
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
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
        textInputAction: TextInputAction.done,
        onChanged: (text){
          _saveCampId(text);
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
        onEditingComplete: () async {
          await  pressButtonToLogin();
        },
      ),
    );
  }

  void _saveName(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Config.shareName, dado);
    userGlobal.name = dado;
  }

  void _savePassword(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Config.sharePassword, dado);
    userGlobal.password = dado;
  }

  void _saveCampId(String dado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Config.shareCamp, dado);
    userGlobal.campId = dado;
  }

  Widget formContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            returnCampoNome(),
            returnCampoSenha(),
            returnCampoCampeonato(),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width*0.5,
              child: Text(
                avisoErro,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pressButtonToLogin() async {
    setState(() {
      loading =true;
    });
    userGlobal.name = controllerNome.text;
    userGlobal.password = controllerSenha.text;
    userGlobal.campId = controllerEvento.text;
    bool success = await consultaDocumentosLogin();
    if(success == true){
      avisoErro = '';
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => new ArbitroScreen())
      // );

      Navigator.pushReplacement(context,
          PageTransition(type:
          PageTransitionType.bottomToTop,
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 1200),
              child: ArbitroScreen()));
    }
    setState(() {
      loading =false;
    });
  }




}