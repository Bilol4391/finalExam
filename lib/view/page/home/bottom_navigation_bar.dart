import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:x_pay/view/page/card_page/add_card2.dart';
import '../../components/style/style.dart';
import '../transaction/transaction.dart';
import 'home_page.dart';
class BottomNB extends StatefulWidget {
  const BottomNB({super.key});



  @override
  // ignore: library_private_types_in_public_api
  _BottomNBState createState() => _BottomNBState();
}

class _BottomNBState extends State<BottomNB> {
  var _currentIndex = 0;
  Future<void> getMassage() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((event) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: "${event.data["title"] ?? "title"} ${event.data["body"] ?? "body"}",
        ),
      );

    });
  }
  List<Widget> listOfPage=[const HomePage(),const  TransactionPage(), const AddCard2(),];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body:listOfPage[_currentIndex],
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 24),

              decoration:  BoxDecoration(
                 // color: Style.blackColor2,
                  gradient: Style.customGeadient(color: Style.greyColor),
                  borderRadius:  const BorderRadius.all( Radius.circular(56))
              ),
              child: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                items: [

                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home_outlined,color: Style.primaryColor,),
                    title: const Text("Home"),
                    selectedColor:Style.primaryColor,
                  ),


                  SalomonBottomBarItem(
                    icon: const Icon(Icons.swap_horizontal_circle_outlined,color: Style.primaryColor,),
                    title: const Text("O'tkazmalar"),
                    selectedColor: Style.primaryColor,
                  ),

                  SalomonBottomBarItem(
                    icon: const Icon(Icons.security_rounded,color: Style.primaryColor,),
                    title: const Text("Xizmatlar"),
                    selectedColor: Style.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}