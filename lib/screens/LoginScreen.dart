import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/screens/CHooseProjectScreen.dart';
import 'package:layblar_app/screens/MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(flex: 4, 
                child: getHeaderSection()
              ),
              Expanded(flex: 6, 
                child: getLoginFormSection()
              )
            ],
          ),
        ),
      ),
    );
  }




  Container getLoginFormSection() {
    return Container(
              decoration: BoxDecoration(
                color: ThemeColors.secondaryBackground,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: Styles.headerTextStyle,),
                    Text("Please sign with the credentials given by your organisation.", style: Styles.regularTextStyle,),
                    Container(
                      decoration: Styles.primaryBackgroundContainerDecoration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          style: Styles.regularTextStyle,
                          controller: usernameController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: ("Username"),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                     Container(
                      decoration: Styles.primaryBackgroundContainerDecoration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          style: Styles.regularTextStyle,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: ("Password"),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(onPressed: ()=> navigateIfSuccessful(), child: const Text("LOGIN",), style: Styles.primaryButtonStyle),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            );
  }


  //TODO: validation etcetc
void validateUser(){
  //validation coming soon
  navigateIfSuccessful();
}

void navigateIfSuccessful(){
      Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context) => const ChooseProjectScreen())));
}

  Container getHeaderSection() {
    return Container(
              color: ThemeColors.primaryBackground,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Layblar", style: Styles.headerTextStyle,),
                  Text("Life is hard, Layble smart!", style: Styles.regularTextStyle,)
                ],
              ),
            );
  }
}

