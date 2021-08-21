import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc_mobile/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../Arbitro.dart';



class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController controllerNome =  new TextEditingController();
TextEditingController controllerSenha=  new TextEditingController();
TextEditingController controllerEvento=  new TextEditingController();


class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  String avisoErro = '';
  bool loading = false;
  String dbNomeArbitros;
  String dbSenhasArbitros;
  String dbIdArbitro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/loginFundo.jpg"),
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
                        child: Image.asset("images/bolaPoomsae.png",
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
                      Text(
                        avisoErro,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: FlatButton(
                            color: Colors.grey,
                            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            onPressed: () async {
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
    _animationController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.initState();


    controllerSenha.text = userGlobal.password;
    controllerNome.text = userGlobal.name;
    controllerEvento.text = userGlobal.campId;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget wppIcon() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Material(
        // needed
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL("https://api.whatsapp.com/send?phone=5547988617244"), // needed
          child: Image.asset(
            "images/whatsapp.png",
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),);
  }

  void verificaDadoParaLogin(BuildContext context) {
    if (dbNomeArbitros == userGlobal.name) {
      userGlobal.userId = dbIdArbitro;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => new ArbitroScreen())
    );
  }

  Future<void> consultaDocumentosLogin() async {
    try {
      final databaseReference = Firestore.instance;
      await databaseReference.collection("${userGlobal.campId}${Config.arbitro}").getDocuments().then((
          QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          bool fechado = f.data['fechado'];

          if(fechado == false) {
            String auxName = '${f.data['nome']}';
            if(auxName == userGlobal.name) {
              dbNomeArbitros = auxName;
              dbSenhasArbitros = '${f.data['senha']}';
              dbIdArbitro = '${f.data['id']}';
            }
          }
        });
      });
    }catch(e){
      print(e);
    }
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
        onChanged: (text){
          _savePassword(text);
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
        onChanged: (text){
          _saveName(text);
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
    await consultaDocumentosLogin();
    verificaDadoParaLogin(context);
    setState(() {
      loading =false;
    });
  }




}