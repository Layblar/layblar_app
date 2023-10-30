import 'package:flutter/material.dart';

import '../Themes/ThemeColors.dart';
class DeviceCardItem extends StatefulWidget {
  const DeviceCardItem({
    Key? key,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);

  final String title;
  final String imgUrl;

  @override
  State<DeviceCardItem> createState() => _DeviceCardItemState();
}

class _DeviceCardItemState extends State<DeviceCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.title),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Image.network(widget.imgUrl)),
            ),
          ],
        ),
      )
    );
  }
}