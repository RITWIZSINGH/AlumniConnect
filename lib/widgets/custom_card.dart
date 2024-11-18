// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, use_super_parameters
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniCard extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String name;
  final String? company;
  final dynamic batch;
  final String? branch;
  final String? profilePicUrl;
  final String? profileLink;
  final VoidCallback onTap;

  const AlumniCard({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.name,
    this.company,
    required this.batch,
    this.branch,
    this.profilePicUrl,
    this.profileLink,
    required this.onTap,
  }) : super(key: key);

  Future<void> _launchURL(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _showReferralDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Request Referral'),
          content: Text('Would you like to request a referral from $name?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add your referral request logic here
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: Colors.teal,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isSelected ? 300 : 120,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: isSelected ? 40 : 30,
                    backgroundImage: profilePicUrl != null 
                      ? NetworkImage(profilePicUrl!) 
                      : null,
                    child: profilePicUrl == null
                        ? Icon(Icons.person,
                            size: isSelected ? 50 : 40, color: Colors.teal)
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toUpperCase(),
                          style: TextStyle(
                              fontSize: isSelected ? 22 : 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        if (company != null) ...[
                          Text(
                            company!,
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                          ),
                          SizedBox(height: 4),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.badge,
                              size: 22,
                              color: Colors.teal.shade600,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Batch of ${batch?.toString() ?? "N/A"}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.teal.shade400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isSelected) ...[
                SizedBox(height: 16),
                if (branch != null) 
                  Text(
                    'Branch: $branch',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showReferralDialog(context),
                      icon: Icon(Icons.person_add),
                      label: Text('Ask for Referral'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                    if (profileLink != null)
                      ElevatedButton.icon(
                        onPressed: () => _launchURL(profileLink),
                        icon: Icon(Icons.link),
                        label: Text('LinkedIn'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}