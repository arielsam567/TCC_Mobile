import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier{
  bool _loading = false;

  bool get loading => _loading;

  HomeController(){
    init();
  }

  Future init() async {
    _loading = true;
    notifyListeners();
    //helps = await _settingsRepository.getHelps();
    _loading = false;
    notifyListeners();
  }




}