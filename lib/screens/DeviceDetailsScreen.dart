import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({ required this.device, Key? key }) : super(key: key);

  final DeviceListItem device;

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: getTopImageSection(context),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.secondaryBackground,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.device.title, style: Styles.headerTextStyle,),
                          Divider(height: 2, color: ThemeColors.textColor,),
                        ],
                      ),
                      
                                
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            getDescriptionItem("Description", "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
                            getDescriptionItem("Manufacturer", "TODO"),
                            getDescriptionItem("Power", "TODO"),
                            getDescriptionItem("Power consumption", "TODO")
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child: Text("Back"), style: Styles.errorButtonStyle,)),
                        ],
                      )
                    ],
                  ),
                ),
            )),
    
          ],
        ),
      ),
    );
  }

  Container getDescriptionItem(String title, String value) {
    return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                     
                      Text(title, style: Styles.regularTextStyle,),
                      SizedBox(height: 8,),
                      Container(
                        decoration: Styles.primaryBackgroundContainerDecoration,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value, style: Styles.regularTextStyle,),
                              ),
                            ),
                          ],
                        ))
                    ],
                  ),
                );
  }

  Container getTopImageSection(BuildContext context) {
    return Container(
              color: ThemeColors.primaryBackground,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back, color: ThemeColors.textColor,), onPressed: ()=> Navigator.of(context).pop(),),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                       
                        child: Image.network(
                          widget.device.imgUrl,
                          fit: BoxFit.fitWidth,  
                        )
                      ),
                    ),
                  ),
                ],
              ),
          );
  }
}