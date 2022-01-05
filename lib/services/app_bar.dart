import 'package:flutter/material.dart';

class StandartAppBar extends StatelessWidget {
  StandartAppBar({
    this.title,
    this.expandedHeight = 0,
    this.flexibleSpace,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  final Widget? title;
  final Widget? flexibleSpace;
  final Widget? leading;
  final List<Widget>? actions;
  final double expandedHeight;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      leading: leading,
      expandedHeight: expandedHeight,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.15),
      title: title,
      flexibleSpace: flexibleSpace,
      iconTheme: IconThemeData(color: Colors.black),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
