// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 2, 0),
      child: AppBar(
        leading: CircleAvatar(),
        title: TextField(
          decoration: InputDecoration(
            hoverColor: Colors.grey.shade600,
            hintText: 'Search',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
