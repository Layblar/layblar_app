import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/StopWatchHoldItem.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/screens/LoginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => StopwatchItemsModel())],
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    //TODO define tetstyle
    return MaterialApp(
      title: 'Flutter Demo',
     theme: ThemeData(
      primaryColor: ThemeColors.primary,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: buildMaterialColor(ThemeColors.primary)),
       

        textTheme: TextTheme(
          bodyLarge: TextStyle(color: ThemeColors.textColor),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: ThemeColors.textColor,
          
    ),
  
      ),
      home: const LoginScreen(),
    );
  }
}


MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}