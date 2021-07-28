import 'package:flutter/material.dart';
import 'package:office_tribal_relations/widgets/categoryListButtons.dart';
import 'package:office_tribal_relations/widgets/searchList.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'about.dart';
import 'contacts.dart';

void main() {
  runApp(OtrHome());
}

class OtrHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office of Tribal Relations (OTR)',
      home: OtrHomeScreen(),
    );
  }
}

class OtrHomeScreen extends StatefulWidget {
  //OtrHomeScreen({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  _OtrHomeScreenState createState() => _OtrHomeScreenState();
}

class _OtrHomeScreenState extends State<OtrHomeScreen> {
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  //var _pageController;
  List<Widget> _screens = [
    CategoryListButtons(),
    JsonContacts(),
    SearchFilter(),
    //AboutOTR()
  ];
  void _onPageChanged(int index) {}
  void _onItemTapped(int selectedIndex) {
    //_pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle
          .neumorphic, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [CategoryListButtons(), JsonContacts(), SearchFilter()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.grey[700],
          ),
          title: ("Home"),
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.secondary),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.mail,
            color: Colors.grey[700],
          ),
          title: ("Contact"),
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.secondary),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.grey[700],
          ),
          title: ("Search"),
          activeColorPrimary: Theme.of(context).colorScheme.primary,
          inactiveColorPrimary: Theme.of(context).colorScheme.secondary),
      // PersistentBottomNavBarItem(
      //     icon: Icon(
      //       Icons.web,
      //       color: Colors.white,
      //     ),
      //     title: ("Website"),
      //     activeColorPrimary: Theme.of(context).colorScheme.primary,
      //     inactiveColorPrimary: Theme.of(context).colorScheme.secondary),
    ];
  }
}
