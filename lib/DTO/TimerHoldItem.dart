import 'package:flutter/material.dart';
import 'package:layblar_app/WIdgets/TimerItem.dart';

class TimerItemsModel extends ChangeNotifier{

  List<TimerItem> _timerItems = [];

    List<TimerItem> get timerItems => _timerItems;


  void addTimerItem(TimerItem item){
    _timerItems.add(item);
    notifyListeners();
  }
}