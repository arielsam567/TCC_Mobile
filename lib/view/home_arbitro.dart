import 'package:auto_size_text/auto_size_text.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tcc_mobile/Config/strings.dart';
import 'package:tcc_mobile/controller/home_controller.dart';
import 'package:tcc_mobile/model/combate_model.dart';
import 'package:tcc_mobile/view/avaliacao/avaliacao_hits.dart';
import 'package:tcc_mobile/view/login_screen.dart';

class ArbitroScreen extends StatefulWidget {
  @override
  _ArbitroScreenState createState() => _ArbitroScreenState();
}

class _ArbitroScreenState extends State<ArbitroScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
          builder: (BuildContext context, HomeController controller, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black54,
                title: Text(Strings.appName),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.autorenew),
                    onPressed: () {
                      controller.consultaDocumentosCompetidores();
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.exit_to_app),
                backgroundColor: Colors.black54,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => new LoginScreen()));
                },
              ),
              body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Toque novamente para sair do app'),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/fundo2.png"),
                          fit: BoxFit.cover)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            child: AutoSizeText("Combates",
                              maxLines: 1,
                              maxFontSize: 50,
                              minFontSize: 25,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            )),
                        if(controller.loading == true)...[
                          Container(
                            height: MediaQuery.of(context).size.height - 200,
                            //alignment: Alignment.center,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white10,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.black),
                              ),
                            ),
                          ),
                        ]else...[
                          listCombates(controller.combates),
                        ]
                      ],
                    ),
                  ),
                ),
              ), //center
            );
          }),
    );
  }

  Widget listCombates(List<CombateModel> items) {
    return ListView.builder(
      itemCount: (items.length),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        bool avaliado = false;
        if(items[index].hitsA > 0 || items[index].hitsB > 0){
          print('avaliado');
          avaliado = true;
        }
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          margin: const EdgeInsets.all(12.0),
          child: Material(
            color: avaliado ? Colors.grey.withOpacity(0.9):  Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(5.0),
            child: Ink(
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: (){
                  Future.delayed(new Duration(milliseconds: 150), () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => new AvaliacaoHits(combateModel: items[index])
                        ));
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.9)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Text('Competidor 1: ${items[index].nameA}'
                          '\nEquipe: ${items[index].equipeA}',
                        style: teste(avaliado),),
                      SizedBox(height: 5,),
                      Divider(thickness: 1.2,
                          color: avaliado ? Colors.white :  Colors.black ),
                      SizedBox(height: 5,),
                      Text('Competidor 2: ${items[index].nameB}'
                          '\nEquipe: ${items[index].equipeB}',
                        style: teste(avaliado),),
                      Divider(thickness: 1.2,
                          color: avaliado ? Colors.white :  Colors.black
                      ),
                      SizedBox(height: 5,),
                      Text('Categoria: ${items[index].categoria}',style: teste(avaliado),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  TextStyle teste(bool contemNota){
    if(contemNota){
      return TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500
      );
    }else{
      return TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
      );
    }

  }

}
