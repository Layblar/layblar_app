import 'package:flutter/material.dart';
import 'package:layblar_app/Widgets/BTMNavigationBar.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({ Key? key }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Charts"),),
      body: Container(child: Text("charts"),),
      bottomNavigationBar: (BTMNavigationBar(currentPage: "Chart", ctx: context,)),
    );
  }
}