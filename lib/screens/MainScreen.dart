// ignore: file_names
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/screens/ChartScreen.dart';
import 'package:layblar_app/screens/DetailsScreen.dart';
import 'package:layblar_app/screens/LabelsScreen.dart';
import 'package:layblar_app/screens/SettingsScreen.dart';

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

  var _currentHouseHold = "Haushalt 1";



  void _loadScreen(){
    switch (_currentIndex){
      case (0): return setState(() => _currentWidget = const TimerScreen());
      case (1): return setState(() => _currentWidget = const DetailsScreen());
      case (2): return setState(() => _currentWidget = const LabelsScreen());
      case (3): return setState(() => _currentWidget = const ChartScreen());
    }
  }

  void _openSettings(){
    Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context) => const SettingsScreen(currentProject: "Project 1",))));
  }

  //TODO: Open settings
  @override
  Widget build(BuildContext context) {
    return PopScope(
     canPop: false,
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        appBar: AppBar(
          centerTitle: true,
          title:  Text(_currentHouseHold, textAlign: TextAlign.center, style: Styles.regularTextStyle,),
          backgroundColor: ThemeColors.secondaryBackground,
          actions: [
            IconButton(icon: Icon(Icons.settings, color: ThemeColors.textColor,), onPressed: () => _openSettings(),)
          ],
          automaticallyImplyLeading: false,
          ),
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
    
      ),
    );
  }
}