import 'package:deepforge_app/Providers/Dark_Mode_Provider.dart';
import 'package:deepforge_app/Providers/deep_provider.dart';
import 'package:deepforge_app/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
                 ChangeNotifierProvider(
      create: (_) => DeepProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DarkMode(),
        )
      ],
      child: Builder(builder:
        (BuildContext context) {
          final themchanger = Provider.of<DarkMode>(context);
          return  MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     themeMode: themchanger.themeMode,
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.red,
            contentTextStyle: TextStyle(color: Colors.white,fontSize: 16)
        ),
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          
          backgroundColor: Colors.white
        ) 
        
      ),
      darkTheme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.red,
          contentTextStyle: TextStyle(color: Colors.white,fontSize: 16)
        ),
        brightness: Brightness.dark,
       
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black
        ),
        
        iconTheme: IconThemeData(
           color: Colors.white
        )
      ),
      home: SplashScreen()
    );
    }
      )
      );
        }
         
}
      
  


