import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc_mobile/Login/widgets/form_container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Arbitro/Arbitro.dart';
import '../main.dart';
import 'widgets/botao_entrar.dart';

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
                  StaggerAnimation(
                    controller: _animationController.view,
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
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _animationController.addStatusListener((status) {
      bool flag = false;
      int acesso = 0;
      if (status == AnimationStatus.completed) {
        if (dbNomeArbitros == nomeUsuarioGlobal) {
          if (dbSenhasArbitros == senhaUsuarioGlobal) {
            valorArbitroGlobal = dbIdArbitro;
            flag = true;
            acesso = 2;
          }
        }


        if (flag && acesso == 2) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new ArbitroScreen())
          );
        }
      }
      else {
        _animationController.duration = Duration(milliseconds: 500);
        _animationController.reverse();
        _animationController.duration = Duration(milliseconds: 3000);
        setState(() {
          avisoErro = 'Verifique seus dados e tente novamente';
        });
      }
    });
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
}









