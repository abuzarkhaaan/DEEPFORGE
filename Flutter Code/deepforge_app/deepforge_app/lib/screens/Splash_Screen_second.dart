import 'package:deepforge_app/components/Buttons.dart';
import 'package:deepforge_app/screens/navbar_screen.dart';
import 'package:flutter/material.dart';


class SplashScreenSecond extends StatefulWidget {
  const SplashScreenSecond({super.key});

  @override
  State<SplashScreenSecond> createState() => _SplashScreenSecondState();
}

class _SplashScreenSecondState extends State<SplashScreenSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 156, 248),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        const    SizedBox(height: 50),
            Image(image: AssetImage('assets/forgelogo1.png')),
            SizedBox(height: 50),
            RoundButton(
             color: Color.fromARGB(255, 4, 122, 219),
                title: 'Lets go',
                onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => navigationbar()));
           })
          ],
        ),
      ),
    );
  }
}