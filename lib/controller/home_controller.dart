import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_mobile/config/config.dart';
import 'package:tcc_mobile/model/combate_model.dart';

import '../main.dart';

class HomeController extends ChangeNotifier{
  final databaseReference = Firestore.instance;
  List<CombateModel> combates = new List();
  bool _loading = false;

  bool get loading => _loading;

  HomeController(){
    init();
  }

  Future init() async {
    _loading = true;
    notifyListeners();
    await consultaDocumentosCompetidores();
    _loading = false;
    notifyListeners();
  }


  consultaDocumentosCompetidores() async {
    combates = new List();
    _loading = true;
    notifyListeners();
    print('consultaDocumentosCompetidores');
    try {
      await databaseReference.collection("${userGlobal.campId}${Config.competidores}")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          print("aqui");
          CombateModel combate = new CombateModel();
          combate.nameA = '${f.data['nome_a']}';
          combate.nameB = '${f.data['nome_b']}';
          combate.equipeA = '${f.data['equipe_a']}';
          combate.equipeB = '${f.data['equipe_b']}';
          combate.categoria = '${f.data['categoria']}';
          combate.hitsA = f.data['${userGlobal.userId}_hits_a'] ?? 0;
          combate.hitsB = f.data['${userGlobal.userId}_hits_b'] ?? 0;
          combate.danoA = f.data['${userGlobal.userId}_dano_a'] ?? 0;
          combate.danoB = f.data['${userGlobal.userId}_dano_b'] ?? 0;
          combate.danoB = f.data['${userGlobal.userId}_dano_b'] ?? 0;
          combate.vencedorDoEmpate = f.data['${userGlobal.userId}_desempate'] ?? 0;
          combate.id = '${f.documentID}';
          combates.add(combate);
        }
        );
      });
      _loading = false;
      notifyListeners();
    }catch(e){
      print(e);
    }

  }


}