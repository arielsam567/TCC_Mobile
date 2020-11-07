import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_requisicao/Administrador/AdmScreen.dart';
import 'package:teste_requisicao/Login/widgets/form_container.dart';
import 'package:teste_requisicao/Mesario/MesarioScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Arbitro/Arbitro.dart';
import '../main.dart';
import 'widgets/botao_entrar.dart';
import 'widgets/botao_limpar.dart';

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


  @override
  Widget build(BuildContext context) {
    heightGlobal = MediaQuery
        .of(context)
        .size
        .height;
    widthGlobal = MediaQuery
        .of(context)
        .size
        .width;
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
                      Text(avisoErro,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,
                      ),
                      SignUpButton(
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
      int acesso=0;
      if(status == AnimationStatus.completed ){


        if(tipoUsuarioGlobal == 'Administrador'){
          int aux = 0;
          dbNomeAdms.forEach((element) {
            if(element == nomeUsuarioGlobal){
              if(dbSenhasAdms[aux] == senhaUsuarioGlobal){
                flag = true;
                acesso = 1;
              }
            }
            aux++;
          });
        }else if(tipoUsuarioGlobal == 'Árbitro'){
          int aux = 0;
          dbNomeArbitros.forEach((element) {
            if(element == nomeUsuarioGlobal){
              if(dbSenhasArbitros[aux] == senhaUsuarioGlobal){
                valorArbitroGlobal = dbIdArbitro[aux];
                flag = true;
                acesso = 2;
              }
            }
            aux++;
          });
        }else if(tipoUsuarioGlobal == 'Mesario'){
          int aux = 0;
          dbNomeArbitros.forEach((element) {
            if(element == nomeUsuarioGlobal){
              if(dbSenhasArbitros[aux] == senhaUsuarioGlobal){
                flag = true;
                acesso = 3;
              }
            }
            aux++;
          });
        }
        if(flag && acesso ==1){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new AdmScreen())
          );
        }else if(flag && acesso ==2){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new ArbitroScreen())
          );
        }else if(flag && acesso == 3 ){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => new MesarioScreen())
          );
        }else{
          _animationController.duration = Duration(milliseconds: 500);
          _animationController.reverse();
          _animationController.duration = Duration(milliseconds: 3000);
          setState(() {
            avisoErro = 'Verifique seus dados e tente novamente';
          });
        }
      }


    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  retornaWpp() {
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









