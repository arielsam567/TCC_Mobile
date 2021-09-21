import 'package:flutter/material.dart';
import 'package:tcc_mobile/config/strings.dart';

class HelpPage extends StatefulWidget {

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(Strings.appName),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/fundo2.png"),
                fit: BoxFit.cover)
        ),

        child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 500),
                elevation: 2,
                expandedHeaderPadding: EdgeInsets.only(left: 20),
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    body: Container(
                      padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                      child: Text(
                        itemData[index].discription,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            letterSpacing: 0.3,
                            height: 1.3),
                      ),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          itemData[index].headerItem,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    },
                    isExpanded: itemData[index].expanded,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    itemData[index].expanded = !itemData[index].expanded;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem: 'TRIVIAL',
      discription: "O nível \“Trivial\” pode ser considerado como a linha base (nível ZERO) ou seja durante o "
          " round o robô combatente não sofreu nenhum tipo de DANO que será contabilizado"
          " pelos juízes."
          "\n\nArranhões visíveis na armadura, rasgos e perda de adesivos ou remoção da pintura, "
          " pequenos cortes ou entalhes não penetrantes no robô irão se enquadrar neste nível do"
          " critério de DANO. Ou seja, não serão contabilizados como DANO para mudança de nível"
          " do critério.",
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem: 'COSMETICO',
      discription: "O nível \“Cosmético\” é o primeiro nível de DANO real que será contabilizado pelos juízes"
          " após a finalização do round."
          "\n\nSerão considerados neste nível os seguintes DANOS:"
          "\n\nRemoção de peças cosméticas não estruturais e não cruciais para o pleno"
          " funcionamento do robô combatente."
          "\n\nExemplos: Perda de itens decorativos (exceto adesivos e pintura), iluminações, dano nas"
          " rodas ou em outra parte móvel exposta não resultando em perda de funcionalidade ou"
          " mobilidade do robô.",
      colorsItem: Colors.blueAccent,
    ),
    ItemModel(
      headerItem: 'MENOR',
      discription: "O nível \“Menor\” é o segundo nível de DANO real que será contabilizado pelos juízes após"
          " a finalização do round. Neste nível serão considerados os DANOS sofridos durante o"
          " round, porém, os mesmos não afetam as funcionalidades principais do robô."
          "\n\nSerão considerados neste nível os seguintes DANOS:"
          "\n\nFumaça intermitente não associada a queda de potência perceptível."
          "\n\nAmassamentos significativos ou cortes penetrantes na estrutura do robô sem que os"
          " mesmos afetem de alguma forma o pleno funcionamento do robô combatente."
          "\n\nRemoção completa de uma roda ou mais, porém sem afetar a mobilidade do robô combatente."
          "\n\nRemoção de componentes de uma estrutura ablativa ou de outros componentes da"
          " arma sem resultar em perda de funcionalidade."
          "\n\nEstruturas apresentando empenamentos, porém sem resultar em perda de mobilidade"
          " ou função da arma do robô combatente.",
      colorsItem: Colors.purple,
    ),
    ItemModel(
      headerItem: 'SIGNIFICATIVO',
      discription: "O nível “Significativo” é o terceiro nível de DANO real que será contabilizado pelos juízes "
          "após a finalização do round. Neste nível serão considerados os DANOS que reduzam "
          "parcialmente as funcionalidades do robô. "
          "\n\nSerão considerados neste nível os seguintes DANOS: "
          "\nFumaça contínua, ou fumaça associada à perda parcial de potência do sistema de "
          "locomoção ou das armas. "
          "\n\nArmaduras rasgadas de forma que reduzam as funcionalidades do robô. "
          "\n\nRemoção completa ou travamento de uma ou mais rodas que cause uma clara perda de "
          "mobilidade."
          "\n\nDanos à arma rotativa, resultando em perda de velocidade da arma ou vibração severa."
          "\n\nDanos ao braço, martelo ou outra parte móvel de um sistema de arma resultando em"
          "perda parcial da sua funcionalidade."
          "\n\nEmpenamentos em eixos, rampas, forks ou outros componentes de ataque de robôs "
          "que não possuam armas ativas de forma que cause uma perda parcial de suas "
          "funcionalidades."
          "\n\nEstrutura do robô visivelmente empenada ou deformada de forma que reduza suas funcionalidades",
      colorsItem: Colors.red,
    ),
    ItemModel(
      headerItem: 'MAIOR',
      discription: "O nível \“Maior\” é o quarto nível de DANO real que será contabilizado pelos juízes após "
          "a finalização do round. Neste nível serão considerados os DANOS que são "
          "completamente críticos para as funcionalidades do robô. "
          "\n\nSerão considerados neste nível os seguintes DANOS:"
          "\n\nFogo visível."
          "\n\nSeção de armadura completamente removida, expondo os componentes internos. "
          "\n\nPerda total da funcionalidade de sistemas de armas ativas. "
          "\n\nRemoção completa de rampas, forks ou outros componentes de ataque de robôs que "
          "não possuam armas ativas. "
          "\n\nComponentes internos arrancados ou que estejam arrastando no chão da arena."
          "\n\nVazamento significativo de fluido hidráulico. "
          "\n\nVazamentos de gases pneumáticos.",
      colorsItem: Colors.amberAccent,
    ),
    ItemModel(
      headerItem: 'MASSIVO',
      discription: "O nível “Massivo” é o quinto e último nível de DANO real que será contabilizado"
          "pelos juízes após a finalização do round."
          "\n\nEste nível somente será considerado quando ocorrer a perda total de energia do robô"
          "combatente no final do round, causando total imobilização do mesmo nos últimos 10"
          "segundos sem que tenha tempo hábil para início da contagem para nocaute."
          "\n\nPerda total de energia no final do round, nos últimos 10 segundos sem que tenha tempo"
          "hábil para início da contagem para nocaute.",
      colorsItem: Colors.deepOrange,
    ),

  ];
}


class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;

  ItemModel({this.expanded: false, this.headerItem, this.discription,this.colorsItem});
}
