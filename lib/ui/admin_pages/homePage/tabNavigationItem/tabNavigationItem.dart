import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/admin_pages/homePage/tabNavigationItem/acceptTab/QRScannerPage.dart';
import 'package:tochka_sbora/ui/admin_pages/homePage/tabNavigationItem/profileTab/profileTab.dart';

class TabNavigationItem {
  final Widget page;
  final String label;
  final Icon activeIcon;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.label,
    required this.activeIcon,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: Scanner(),
      label: "Принять",
      activeIcon: Icon(Icons.input),
      icon: Icon(Icons.input_outlined),
    ),
    TabNavigationItem(
      page: ProfileTab(),
      label: "Профиль",
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outlined),
    ),
  ];
}
