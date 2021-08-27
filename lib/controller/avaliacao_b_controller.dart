import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_mobile/config/config.dart';
import 'package:tcc_mobile/model/combate_model.dart';

import '../main.dart';

class AvaliacaoBController extends ChangeNotifier{
  final databaseReference = Firestore.instance;
  final String id;
  bool _loading = false;

  AvaliacaoBController(this.id);

  bool get loading => _loading;



  finaliza(CombateModel combate) {

    try{
      databaseReference.collection("${userGlobal.campId}${Config.competidores}")
          .document(id).updateData({
        '${userGlobal.userId}$campo': valor,
      });
    }catch(e){

    }
  }

}