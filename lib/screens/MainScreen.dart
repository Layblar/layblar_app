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
      backgroundColor: ThemeColors.primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Layblar", textAlign: TextAlign.center,),
        backgroundColor: ThemeColors.secondaryBackground,),
      body: _currentWidget,
      bottomNavigationBar: 
      BottomNavigationBar(
        selectedItemColor: ThemeColors.primary,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: ThemeColors.textColor),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _loadScreen();
        },
      items:  [
        BottomNavigationBarItem(
        icon: Icon(Icons.timer, color: _currentIndex == 0?ThemeColors.primary:ThemeColors.primaryDisabled),
        label: "Timer",
        backgroundColor: ThemeColors.secondaryBackground

      ),
         BottomNavigationBarItem(
        icon: Icon(Icons.more, color: _currentIndex == 1?ThemeColors.primary:ThemeColors.primaryDisabled),
        label: "Details",
        backgroundColor: ThemeColors.secondaryBackground

      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.label_important, color: _currentIndex == 2?ThemeColors.primary:ThemeColors.primaryDisabled),
        label: "Labels",
        backgroundColor: ThemeColors.secondaryBackground

      ),
       BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart, color: _currentIndex == 3?ThemeColors.primary:ThemeColors.primaryDisabled),
        label: "Chart",
        backgroundColor: ThemeColors.secondaryBackground

      ),
      ]
    ),

    );
  }
}