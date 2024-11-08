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
  final VoidCallback onTap;

  const AlumniCard({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.name,
    required this.company,
    required this.batch,
    required this.profilePicUrl,
    required this.profileLink,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      // color: Colors.teal,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: Colors.teal,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(profilePicUrl),
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback for failed image loading
                },
                child: Image.network(
                  profilePicUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 40, color: Colors.teal);
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(company,
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
                    SizedBox(height: 4),
                    Text('Batch of $batch',
                        style: TextStyle(fontSize: 14, color: Colors.teal)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
