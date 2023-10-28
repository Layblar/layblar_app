import 'package:flutter/material.dart';
import 'package:layblar_app/screens/DetailsScreen.dart';

class NavigationRoutes{

  static void navigateToDetails(BuildContext context){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DetailsScreen()),
  );
  }

  static void navigateToLabels(){

  }

  static void navigateToChart(){

  }

  static void navigateToTimer(){

  }

}