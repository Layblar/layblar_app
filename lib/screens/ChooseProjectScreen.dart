
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/screens/MainScreen.dart';

class ChooseProjectScreen extends StatefulWidget {
  const ChooseProjectScreen({ Key? key }) : super(key: key);

  @override
  State<ChooseProjectScreen> createState() => _ChooseProjectScreenState();
}

class _ChooseProjectScreenState extends State<ChooseProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: ThemeColors.secondaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text("Choose your Project", style: Styles.headerTextStyle,),
            SizedBox(height: 32,),

            Column(
              children: [
                Container(decoration: Styles.primaryBackgroundContainerDecoration, child: ListTile(title: Text("Project 1", style: TextStyle(color: ThemeColors.primary),), subtitle: Text("This Project is about labeling Coffe machines", style: Styles.regularTextStyle,), trailing: Text("Choose This Project"),)),
                SizedBox(height: 8),
                Container(decoration: Styles.primaryBackgroundContainerDecoration, child: ListTile(title: Text("Project 2", style: TextStyle(color: ThemeColors.secondary)), subtitle: Text("This one as well",  style: Styles.regularTextStyle),  trailing: Text("Join This Project"))),
                SizedBox(height: 8),
                Container(decoration: Styles.primaryBackgroundContainerDecoration, child: ListTile(title: Text("Project 3", style: TextStyle(color: ThemeColors.secondary),),subtitle: Text("This Project is about labeling TVs",  style: Styles.regularTextStyle),  trailing: Text("Join This Project")))
              ],
            ),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: ()=> navigateIfSuccessful(), child: Text("Proceed"), style: Styles.primaryButtonStyle,)),
              ],
            )
          ],
        ),
      ),
    ));
  }

  void navigateIfSuccessful(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }
}