import 'package:flutter/material.dart';

class ParkyDrawer extends StatelessWidget {
  const ParkyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColorTheme = theme.iconTheme.color;
    final textTheme = theme.textTheme.labelLarge;
    const tilePadding = EdgeInsets.only(left: 8.0, right: 8, top: 8);

    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.car_rental,
              color: iconColorTheme,
              size: 64,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              leading: Icon(Icons.home, color: iconColorTheme),
              title: Text('H O M E', style: textTheme),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/add_vehicle');
              },
              leading: Icon(Icons.add, color: iconColorTheme),
              title: Text(
                'R E G I S T E R   V E H I C L E',
                style: textTheme,
              ),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              leading: Icon(Icons.person, color: iconColorTheme),
              title: Text(
                'P R O F I L E',
                style: textTheme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
