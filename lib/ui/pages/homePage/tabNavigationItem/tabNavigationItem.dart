import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/shopTab/shopTab.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/mapTab.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/profileTab.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/acceptTab/QRScannerPage.dart';

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
      page: ShopTab(),
      label: "Магазин",
      activeIcon: Icon(Icons.store),
      icon: Icon(Icons.store_outlined),
    ),
    TabNavigationItem(
      page: MapTab(),
      label: "Карта",
      activeIcon: Icon(Icons.pin_drop),
      icon: Icon(Icons.pin_drop_outlined),
    ),
    TabNavigationItem(
      page: ProfileTab(),
      label: "Профиль",
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outlined),
    ),
    TabNavigationItem(
      page: Scanner(),
      label: "Принять",
      activeIcon: Icon(Icons.input),
      icon: Icon(Icons.input_outlined),
    ),
  ];
}
