import 'dart:math';
import 'package:dash_button_app/screens/content_box.dart';
import 'package:dash_button_app/screens/gallery_page.dart';
import 'package:dash_button_app/screens/demo.dart';
import 'package:dash_button_app/screens/home.dart';
import 'package:dash_button_app/screens/likes_page.dart';
import 'package:dash_button_app/screens/qr_code_scan.dart';
import 'package:dash_button_app/widgets/navbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;

  List<Widget> _viewsByIndex;

  @override
  void initState() {
    //Declare some buttons for our tab bar
    _navBarItems = [
      NavBarItemData("Principal", Icons.home, 120, Color(0xff01b87d)),
      NavBarItemData("Favoritos", Icons.favorite, 120, Color(0xff594ccf)),
      NavBarItemData("Histórico", Icons.history, 120, Color(0xff09a8d9)),
      NavBarItemData("Perfil", Icons.person, 100, Color(0xffcf4c7a)),
      NavBarItemData("Câmera", Icons.camera, 120, Color(0xfff2873f)),
    ];

    //Create the views which will be mapped to the indices for our nav btns
    _viewsByIndex = <Widget>[
      Home(),
      GalleryPage(),
      LikesPage(),
      ContentBox(),
      QRViewExample()
      // TODO: Add other screens
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Create custom navBar, pass in a list of buttons, and listen for tap event
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index
    var contentView = _viewsByIndex[min(_selectedNavIndex, _viewsByIndex.length - 1)];
    //Wrap our custom navbar + contentView with the app Scaffold
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          //Wrap the current page in an AnimatedSwitcher for an easy cross-fade effect
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            //Pass the current accent color down as a theme, so our overscroll indicator matches the btn color
            child: contentView
          ),
        ),
      ),
      bottomNavigationBar: navBar, //Pass our custom navBar into the scaffold
    );
  }

  void _handleNavBtnTapped(int index) {
    //Save the new index and trigger a rebuild
    setState(() {
      //This will be passed into the NavBar and change it's selected state, also controls the active content page
      _selectedNavIndex = index;
    });
  }
}
