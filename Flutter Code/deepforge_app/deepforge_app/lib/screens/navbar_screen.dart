



import 'package:deepforge_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:deepforge_app/screens/Seetings_Screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';



class navigationbar extends StatefulWidget {
  const navigationbar({super.key});

  @override
  State<navigationbar> createState() => _navigationbarState();
}

class _navigationbarState extends State<navigationbar> {

   final _controller = PersistentTabController(initialIndex: 0);
  

 List<Widget> screens() {
    return [
     const HomeScreen(),
     const      SeetingScreen()
    ];
  }    
   List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(    
        icon: Icon(Icons.home),
        title: "Home",
     activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.blue
      ),
      PersistentBottomNavBarItem(    
        icon: Icon(Icons.settings),       
        title: "Settings",
          activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        activeColorSecondary: Colors.blue,
        
      ),  
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {},
          child: PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(),
            controller: _controller,
            navBarHeight: 47,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            padding: const NavBarPadding.symmetric(horizontal: 0),
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
           const     BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                ),
              ],
              colorBehindNavBar: Colors.black,
            ),
            navBarStyle: NavBarStyle.style9,
            popAllScreensOnTapOfSelectedTab: true,
          
        ))));
  }
  
 
}