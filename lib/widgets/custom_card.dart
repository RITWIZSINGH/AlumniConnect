// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, use_super_parameters
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:ui';

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
    try {
      if (url != null && await canLaunchUrlString(url)) {
        await launchUrlString(url);
      }
    } on PlatformException catch (e) {
      debugPrint('URL launcher error: $e');
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

  Widget _buildExpandedCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Centered card
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.teal.shade200,
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: profilePicUrl != null
                                ? NetworkImage(profilePicUrl!)
                                : null,
                            child: profilePicUrl == null
                                ? Icon(Icons.person,
                                    size: 80, color: Colors.teal)
                                : null,
                          ),
                        ),
                        SizedBox(height: 24),

                        // Name
                        Text(
                          name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),

                        // Company
                        if (company != null) ...[
                          Text(
                            company!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                        ],
                        // Batch and Branch
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.school, color: Colors.teal),
                                  SizedBox(width: 8),
                                  Text(
                                    'Batch of ${batch?.toString() ?? "N/A"}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.teal.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              if (branch != null) ...[
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.engineering, color: Colors.teal),
                                    SizedBox(width: 8),
                                    Text(
                                      branch!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.teal.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _showReferralDialog(context),
                                icon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'ASK 4 REFERRAL',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            if (profileLink != null)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _launchURL(profileLink),
                                  icon: Icon(
                                    Icons.link,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'LinkedIn',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedCard() {
    return Card(
      elevation: 2,
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
                backgroundImage:
                    profilePicUrl != null ? NetworkImage(profilePicUrl!) : null,
                child: profilePicUrl == null
                    ? Icon(Icons.person, size: 40, color: Colors.teal)
                    : null,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (company != null) ...[
                      SizedBox(height: 4),
                      Text(
                        company!,
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      ),
                    ],
                    SizedBox(height: 4),
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
                            fontSize: 14,
                            color: Colors.teal.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return _buildExpandedCard(context);
    }
    return _buildCollapsedCard();
  }
}
