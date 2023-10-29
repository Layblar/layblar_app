import 'package:flutter/material.dart';

class LabelsScreen extends StatefulWidget {
  const LabelsScreen({ Key? key }) : super(key: key);

  @override
  State<LabelsScreen> createState() => _LabelsScreenState();
}

class _LabelsScreenState extends State<LabelsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(child: Text("Alle labels"));
     
  }
}