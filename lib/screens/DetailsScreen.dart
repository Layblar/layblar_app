import 'package:flutter/material.dart';
import 'package:layblar_app/Widgets/BTMNavigationBar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projekt XY")),
      body:  Container(child:  const Text("In diesem Projekt labeln wir kaffeemaschinen, das macht unheimlich viel spass")),
      bottomNavigationBar: BTMNavigationBar(currentPage: "Details", ctx: context,),
    );
  }
}