import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_mobile/config/config.dart';

import '../main.dart';

class AvaliacaoAController extends ChangeNotifier{
  final databaseReference = Firestore.instance;
  final String id;
  bool _loading = false;

  AvaliacaoAController(this.id);

  bool get loading => _loading;


  updateHits(String campo, int valor){
    // firestoreInstance
    //     .collection("users")
    //     .doc(firebaseUser.uid)
    //     .update({"age": 60}).then((_) {
    //   print("success!");
    // });


    try{
      databaseReference.collection("${userGlobal.campId}${Config.competidores}")
          .document(id).updateData({
        '${userGlobal.userId}$campo': valor,
      });
    }catch(e){

    }
  }

}