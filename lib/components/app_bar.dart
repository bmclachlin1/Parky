import 'package:flutter/material.dart';

class ParkyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ParkyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Parky"),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
