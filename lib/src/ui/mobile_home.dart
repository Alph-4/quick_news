import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  bool? _isConnected;
  late StreamSubscription<InternetConnectionStatus> subscription;
  setCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final connectionChecker = InternetConnectionChecker();

    subscription = connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.connected) {
          print('Connected to the internet');
          setState(() {
            _isConnected = true;
          });
        } else {
          print('Disconnected from the internet');
          setState(() {
            _isConnected = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                // Show the error bar when not connected
                Container(
                  color: Colors.red,
                  height: _isConnected != null && !_isConnected! ? 50 : 0,
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
