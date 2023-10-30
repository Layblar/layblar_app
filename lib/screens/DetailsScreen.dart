import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);



//about the project
//devices (karusell?) mit click darauf popup öffnen
  @override
  Widget build(BuildContext context) {
    return   Container(child:  const Text("In diesem Projekt labeln wir kaffeemaschinen, das macht unheimlich viel spass"));
  }
}