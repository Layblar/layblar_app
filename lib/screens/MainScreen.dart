import 'package:flutter/material.dart';
import 'package:layblar_app/screens/ChartScreen.dart';
import 'package:layblar_app/screens/DetailsScreen.dart';
import 'package:layblar_app/screens/LabelsScreen.dart';

import '../Themes/ThemeColors.dart';
import 'TimerScreen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


   Widget _currentWidget = TimerScreen();
   
  var _currentIndex = 0;



  void _loadScreen(){
    switch (_currentIndex){
      case (0): return setState(() => _currentWidget = TimerScreen());
      case (1): return setState(() => _currentWidget = DetailsScreen());
      case (2): return setState(() => _currentWidget = LabelsScreen());
      case (3): return setState(() => _currentWidget = ChartScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Hallo")),
      body: _currentWidget,
      bottomNavigationBar: 
      BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _loadScreen();
        },
      items:  [
        BottomNavigationBarItem(
        icon: Icon(Icons.watch, color: _currentIndex == 0?ThemeColors.primary:ThemeColors.secondary),
        label: "Timer"
      ),
         BottomNavigationBarItem(
        icon: Icon(Icons.lens, color: _currentIndex == 1?ThemeColors.primary:ThemeColors.secondary),
        label: "Details",
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.label, color: _currentIndex == 2?ThemeColors.primary:ThemeColors.secondary),
        label: "Labels",
      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.monitor, color: _currentIndex == 3?ThemeColors.primary:ThemeColors.secondary),
        label: "Chart",
      ),
      ]
    ),

    );
  }
}