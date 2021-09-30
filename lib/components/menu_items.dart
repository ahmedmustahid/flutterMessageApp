import 'package:chat/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [itemVisualisation, itemLogout];
  static const List<MenuItem> itemsSecond = [itemLogout];

  static const itemVisualisation = MenuItem(
      menuItemName: 'Visualization',
      menuIcon: Icon(
        Icons.scatter_plot,
        color: Colors.black,
      ));

  static const itemLogout = MenuItem(
      menuItemName: 'Logout',
      menuIcon: Icon(
        Icons.logout,
        color: Colors.black,
      ));

  static const itemChat = MenuItem(
      menuItemName: 'Chat',
      menuIcon: Icon(
        Icons.chat,
        color: Colors.black,
      ));
}
