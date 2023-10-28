import 'package:flutter/material.dart';
import 'package:layblar_app/Widgets/BTMNavigationBar.dart';

class LabelsScreen extends StatefulWidget {
  const LabelsScreen({ Key? key }) : super(key: key);

  @override
  State<LabelsScreen> createState() => _LabelsScreenState();
}

class _LabelsScreenState extends State<LabelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("labels"),
      ),
      body:  Container(child: Text("Alle labels"),),
      bottomNavigationBar: BTMNavigationBar(currentPage: "Labels", ctx: context,),
    );
  }
}