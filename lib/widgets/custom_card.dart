// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AlumniCard extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String name;
  final String company;
  final int batch;
  final String profilePicUrl;
  final String profileLink;
  final Function onTap;

  AlumniCard({
    required this.index,
    required this.isSelected,
    required this.name,
    required this.company,
    required this.batch,
    required this.profilePicUrl,
    required this.profileLink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: isSelected ? Colors.blue[100] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePicUrl),
                radius: 30.0,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(company),
                  Text('Batch: $batch'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
