import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';

import '../Themes/Styles.dart';
import '../Themes/ThemeColors.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

bool isAboutViewSelected = true;
bool isDevicesViewSelected = false;

final String ABOUT_PAGE = "ABOUT";
final String DEVICE_PAGE = "DEVICE";


List<DeviceListItem> deviceMocks = DeviceCardMockDTO.generateCards();



 void toggleView(String selectedView){

    if(selectedView == ABOUT_PAGE){
      setState(() {
       isAboutViewSelected = true;
       isDevicesViewSelected = false;
      });
    }else if(selectedView == DEVICE_PAGE){
      setState(() {
       isAboutViewSelected = false;
       isDevicesViewSelected = true;
      });
    }
 }

//about the project
  @override
  Widget build(BuildContext context) {


    //header seaction
    //project -- devices
    return   Column(
      children: [
        Expanded(
          flex: 1,
          child: getToggleViewSection()
        ),
        Expanded(
          flex: 8,
          child: isAboutViewSelected? getAboutSection() : getDeviceListSection()
        )
      ],
    );
  }

  Container getDeviceListSection() {
    return Container(
          decoration: Styles.containerDecoration,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:  Column(
              children: [
                Text("Here you can see all the Devices provided by your Organisation", style: Styles.regularTextStyle),
                SizedBox(height: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: deviceMocks
                  .where((e) => e.title != "")
                  .map((e) => 
                    Column(
                      children: [
                        Container(
                          decoration: Styles.primaryBackgroundContainerDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60, // Passe die Bildbreite nach Bedarf an
                                  height: 60, // Passe die Bildhöhe nach Bedarf an
                                  child: e.imgUrl.isNotEmpty
                                    ? Image.network(e.imgUrl, fit: BoxFit.fitWidth)
                                    : const Placeholder(), // Falls kein Bild vorhanden ist
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(e.title, style: Styles.regularTextStyle),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.arrow_forward, color: ThemeColors.textColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16,)
                      ],
                    )) 
                  .toList()
                ),
              ],
            ),
          ),
        );
  }

  Container getAboutSection() {
    return Container(
          margin: const EdgeInsets.only(left: 8, top:8, right: 8, bottom:8),
          decoration: Styles.containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About this Project", style: Styles.headerTextStyle,),
                SizedBox(height: 8,),
                Text("This Project is focusing on the Labeling of general Household items like Coffee machines, Washing machines and Kebap grills.", style: Styles.regularTextStyle,)
              ],
            ),
          ),

        );
  }

  Container getToggleViewSection() {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        decoration: Styles.containerDecoration,
        child: Row(
          children: [
            Expanded(flex:1, 
            child: GestureDetector(
              onTap: ()=> toggleView(ABOUT_PAGE),
              child: Container(
                decoration: isAboutViewSelected?Styles.selctedContainerDecoration:null,
                child:  Center(
                  child: Text("About this Project" , style: TextStyle(color: isAboutViewSelected? ThemeColors.secondaryBackground: ThemeColors.textColor)),)),
            ),),
            Expanded(
              flex:1,
              child: GestureDetector(
                onTap: ()=> toggleView(DEVICE_PAGE),
                child: Container(
                  decoration: isDevicesViewSelected?Styles.selctedContainerDecoration:null,
                child:  Center(
                  child: Text("All Devices", style: TextStyle(color: isDevicesViewSelected?ThemeColors.secondaryBackground: ThemeColors.textColor),),)),
              ),
            ),
           

          ],
        ),
      );
  }
}