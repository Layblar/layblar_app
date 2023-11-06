import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';

import 'LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: ThemeColors.secondaryBackground,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: ThemeColors.textColor,), onPressed: ()=> navigateBack(),),
      ),
      backgroundColor: ThemeColors.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){}, child: const Text("Change Household"), style: Styles.primaryButtonStyle,),
          ElevatedButton(onPressed: ()=> logout(), child: const Text("Logout"), style: Styles.errorButtonStyle,),
          ElevatedButton(onPressed: () => navigateBack(), child: const Text("Back"), style: Styles.secondaryButtonStyle,)
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
}