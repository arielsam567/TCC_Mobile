import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_mobile/config/config.dart';

import '../main.dart';

class AvaliacaoDesempateController extends ChangeNotifier{
  final databaseReference = Firestore.instance;
  final String id;
  bool _loading = false;

  AvaliacaoDesempateController(this.id);

  bool get loading => _loading;


  updateHits(String campo, int valor){
    try{
      databaseReference.collection("${userGlobal.campId}${Config.competidores}")
          .document(id).updateData({
        '${userGlobal.userId}$campo': valor,
      });
    }catch(e){

    }
  }

}