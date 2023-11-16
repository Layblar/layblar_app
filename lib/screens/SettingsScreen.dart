// ignore: file_names
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';

import 'LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ required this.currentProject, Key? key }) : super(key: key);

  final String currentProject;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  List<String> availableProjects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    availableProjects = ["Project 1, Project 2, Project 3"];
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title:  Text("Settings", style: Styles.regularTextStyle,),
        centerTitle: true,
        backgroundColor: ThemeColors.secondaryBackground,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: ThemeColors.textColor,), onPressed: ()=> navigateBack(),),
      ),
      backgroundColor: ThemeColors.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Current Project: " + widget.currentProject),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: ()=> openProjectsDialoge(), child: const Text("Change Project"), style: Styles.primaryButtonStyle,)),
            ],
          ),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: ()=> logout(), child: const Text("Logout"), style: Styles.errorButtonStyle,)),
            ],
          ),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => navigateBack(), child: const Text("Back"), style: Styles.secondaryButtonStyle,)),
            ],
          )
        ],
      ),
    );
  }


//TODO: apply logic so the household updates, amybe a new call etc
  void navigateBack(){
    Navigator.of(context).pop();
  }

  void logout(){
    Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context) => const LoginScreen())));
  }


  //TODO: Dynamic projects
  void openProjectsDialoge(){
    debugPrint("[-------CURRENT----]" +  widget.currentProject);
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Change Project"),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: 
              availableProjects.map((e) => GestureDetector(
                onTap: () => setState(() {
                
                }),
                child: Container(
                  color: widget.currentProject == e? ThemeColors.primary: ThemeColors.primaryBackground,
                  child: ListTile(title: Text(e, style: TextStyle(color: widget.currentProject == e? ThemeColors.primaryBackground: ThemeColors.textColor,),)),
                          ),
              )).toList(),
        ),
        actions: [
          ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child: const Text("Cancel"), style: Styles.errorButtonStyle,),
          ElevatedButton(onPressed: (){}, child: const Text("Change Project"), style: Styles.primaryButtonStyle,)
        ],
      );
    });
  }
}