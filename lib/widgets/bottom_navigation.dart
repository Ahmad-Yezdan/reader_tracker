import 'package:flutter/material.dart';
import 'package:reader_tracker/providers/major_provider.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.theme,
    required this.provider,
  });

  final ThemeData theme;
  final MajorProvider provider;

  @override
  Widget build(BuildContext context) {
    var background = theme.colorScheme.primary;
    var onBackground = theme.colorScheme.inversePrimary;
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent, // background color of active item
      color:
          onBackground, // fill color of navigation bar(and active item if buttonBackgroundColor attribute is not used)
      // buttonBackgroundColor: Colors.transparent,   // fill color of active item's circle
      animationDuration: const Duration(milliseconds: 500),
      items: <CurvedNavigationBarItem>[
        CurvedNavigationBarItem(
            child: Icon(
              Icons.home,
              color: background,
            ),
            label: "Home",
            labelStyle: TextStyle(color: background)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.save,
              color: background,
            ),
            label: "Saved",
            labelStyle: TextStyle(color: background)),
        CurvedNavigationBarItem(
            child: Icon(
              Icons.favorite,
              color: background,
            ),
            label: "Favorites",
            labelStyle: TextStyle(color: background)),
      ],
      index: provider.currentIndex,
      onTap: (value) {
        provider.updateIndex(value);
      },
    );
  }
}
