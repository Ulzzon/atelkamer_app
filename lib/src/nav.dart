// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'list_images.dart';


class _TabInfo {
  const _TabInfo(this.title, this.icon);

  final String title;
  final IconData icon;
}

class CupertinoTabBarDemo extends StatelessWidget {
  const CupertinoTabBarDemo();

  @override
  Widget build(BuildContext context) {
    final _tabInfo = [
      _TabInfo(
        'Home',
        CupertinoIcons.home,
      ),
      _TabInfo(
        'Charts',
        CupertinoIcons.chart_bar_alt_fill,
      ),
      _TabInfo(
        'Activities',
        CupertinoIcons.square_list_fill,
      ),
    ];

    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.textStyle,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            for (final tabInfo in _tabInfo)
              BottomNavigationBarItem(
                title: Text(tabInfo.title),
                icon: Icon(tabInfo.icon),
              ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) => _CupertinoDemoTab(
              title: _tabInfo[index].title,
              icon: _tabInfo[index].icon,
            ),
            defaultTitle: _tabInfo[index].title,
          );
        },
      ),
    );
  }
}

class _CupertinoDemoTab extends StatelessWidget {
  const _CupertinoDemoTab({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    StatelessWidget pageWidget;
    if(title == 'Home'){
      pageWidget = HomePage();
    }else if(title == 'Charts'){

    }else if(title == 'Activities'){
      pageWidget = ActivityPage();
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      backgroundColor: CupertinoColors.systemBackground,
      child: pageWidget,
    );
  }
}

