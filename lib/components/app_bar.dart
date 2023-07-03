import 'package:flutter/material.dart';

class ParkyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const ParkyAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? "Parky"),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
