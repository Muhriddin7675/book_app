import 'package:flutter/material.dart';
import 'package:flutter_firabase_book_app/util/utils.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String appBarName;
  final Color appBarColor;
  final Color textColor;
  final IconData? leadingIcon;
  final IconData? action;
  final Color? iconColor;

  const AppBarComponent(
      {super.key, required this.appBarName, required this.appBarColor, required this.textColor, required this.leadingIcon, required this.action, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
      title: Center(
        child: Text(
          appBarName,
          style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Nui Neue'),
        ),
      ),
      leading: IconButton(
        icon: Icon(leadingIcon ,color: iconColor,),
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            action,
            color: Colors.black,
          ),
          tooltip: 'More',
          onPressed: () {},
        ),
      ],
      elevation: 0,
      backgroundColor: appBarColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
