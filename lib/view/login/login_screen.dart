import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_mobile/view/login/widgets/form_container.dart';
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
                              child: FormContainer(
                              ),
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
                  retornaWpp(),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child:Material(
                        // needed
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _launchURL("https://www.instagram.com/taekwondodezdan/"), // needed
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
                          onTap: () => _launchURL("https://www.facebook.com/dezdan.dezdan/"), // needed
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

  Widget retornaWpp() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Material(
        // needed
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL("https://api.whatsapp.com/send?phone=5548996499889"), // needed
          child: Image.asset(
            "images/whatsapp.png",
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),);
  }

  void verificaDadoParaLogin(BuildContext context) {
    bool flag = true;
    int acesso = 2;
    if (dbNomeArbitros == userGlobal.name) {
      userGlobal.userId = dbIdArbitro;
    }
    if (flag && acesso == 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => new ArbitroScreen())
      );
    }
  }

  Future<void> consultaDocumentosLogin() async {
    try {
      final databaseReference = Firestore.instance;
      await databaseReference.collection("${userGlobal.campId}-Arbitros").getDocuments().then((
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



}