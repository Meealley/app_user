import 'package:flutter/material.dart';
import 'package:kfc/view/account/account_screen.dart';
import 'package:kfc/view/bottomnavigationbar/widgets/bottom_nav_widgets.dart';
import 'package:kfc/view/cart/cart_screen.dart';
import 'package:kfc/view/category/category_screen.dart';
import 'package:kfc/view/home/home_screen.dart';
import 'package:kfc/view/search/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationUser extends StatefulWidget {
  const BottomNavigationUser({super.key});

  @override
  State<BottomNavigationUser> createState() => _BottomNavigationUserState();
}

class _BottomNavigationUserState extends State<BottomNavigationUser> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CategoryScreen(),
      const SearchScreen(),
      const CartScreen(),
      const AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        // title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.category),
        // title: ("Category"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        // title: ("Search"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_grocery_store),
        // title: ("Cart"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        // title: ("Account"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavWidgets(
      controller: _controller,
      buildScreens: _buildScreens(),
      navBarItems: _navBarsItems(),
    );
  }
}
