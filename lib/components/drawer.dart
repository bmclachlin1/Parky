import 'package:firebase_auth/firebase_auth.dart';
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
              leading: Icon(Icons.apartment, color: iconColorTheme),
              title: Text('L O C A T I O N S', style: textTheme),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/vehicles');
              },
              leading: Icon(Icons.car_rental, color: iconColorTheme),
              title: Text('V E H I C L E S', style: textTheme),
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
                'P A R K   V E H I C L E',
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
          Padding(
            padding: tilePadding,
            child: ListTile(
              onTap: () async {
                Navigator.of(context).pushNamed('/');
                await FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.arrow_back, color: iconColorTheme),
              title: Text(
                'L O G O U T',
                style: textTheme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
