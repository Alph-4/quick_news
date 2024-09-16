import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:quick_news/src/data/service/connectivity_service.dart';
import 'package:quick_news/src/ui/media/media_page.dart';
import 'package:quick_news/src/ui/news/news_page.dart';
import 'package:quick_news/src/ui/profile/profile_page.dart';
import 'package:quick_news/src/ui/search/search_page.dart';

class MobileAppHomePage extends StatefulWidget {
  const MobileAppHomePage({super.key});

  @override
  State<MobileAppHomePage> createState() => _MobileAppHomePageState();
}

class _MobileAppHomePageState extends State<MobileAppHomePage> {
  int _currentPageIndex = 0;
  bool _isConnected = true; // Variable to store the connection status

  setCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final connectivityService = ConnectivityService(Connectivity());

    // Check the internet connection on initState
    connectivityService.checkInternetConnection().then((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });

    // Listen to connectivity changes
    connectivityService.onConnectivityChanged.listen((connectivityResult) {
      setState(() {
        _isConnected = connectivityResult != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                if (!_isConnected)
                  // Show the error bar when not connected
                  Container(
                    color: Colors.red,
                    height: 50,
                    child: const Center(
                      child: Text(
                        'No internet connection',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                Expanded(
                  child: IndexedStack(
                    index: _currentPageIndex,
                    children: const [
                      NewsPage(),
                      SearchPage(),
                      MediaPage(),
                      ProfilePage(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: NavigationBar()));
  }

  Widget NavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (value) => setCurrentPageIndex(value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.source), label: "Media"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ]);
  }
}
