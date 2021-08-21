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
    consultaDocumentosCompetidores();
    _loading = false;
    notifyListeners();
  }


  consultaDocumentosCompetidores() async {
    try {
      databaseReference.collection("${userGlobal.campId}${Config.competidores}").orderBy('nome')
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
            CombateModel combate = new CombateModel();
            combate.nameA = '${f.data['nome']}';
            combate.nameB = '${f.data['nome2']}';
            combate.equipeA = '${f.data['equipe']}';
            combate.equipeB = '${f.data['equipe2']}';
            combate.categoria = '${f.data['categoria']}';
            combates.add(combate);

        }
        );
      });
    }catch(e){
      print(e);
    }
  }


}