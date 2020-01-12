import 'package:flutter/material.dart';
import 'package:virtual_store/Screens/home_tab.dart';
import 'package:virtual_store/Screens/products_tab.dart';
import 'package:virtual_store/widgets/custom_drawer.dart';
import '../extensions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            body: HomeTab(colorRGB(211, 118, 130)),
            drawer: CustomDrawer(_pageController),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Products"),
              centerTitle: true,
            ),
            body: ProductsTab(),
            drawer: CustomDrawer(_pageController),
          ),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        onTap: onNavigationTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                "Store",
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), title: Text("Products")),
          BottomNavigationBarItem(
              icon: Icon(Icons.store), title: Text("Store")),
          BottomNavigationBarItem(
              icon: Icon(Icons.store), title: Text("Store")),
        ],
      ),
    );
  }

  onNavigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
