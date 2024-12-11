import 'package:flutter/material.dart';
import '/services/auth_service.dart';
import '/screens/authScreens/sign_in_screen.dart';
import '/screens/profile_screen.dart';
import '/widgets/app_bar/search_field.dart';
import '/widgets/app_bar/app_bar_button.dart';

class CustomAppBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final AuthService _authService = AuthService();

  CustomAppBar({
    Key? key,
    required this.searchController,
    required this.onFilterTap,
  }) : super(key: key);

  void _handleAuthNavigation(BuildContext context) {
    if (_authService.isLoggedIn()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue.shade700,
      floating: true,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      snap: true,
      leadingWidth: 72,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: AppBarButton(
          icon: _authService.isLoggedIn() ? Icons.person : Icons.login,
          onPressed: () => _handleAuthNavigation(context),
          tooltip: _authService.isLoggedIn() ? 'Profile' : 'Login',
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AppBarButton(
            icon: Icons.tune,
            onPressed: onFilterTap,
            tooltip: 'Filter',
          ),
        ),
      ],
      title: Center(
        child: SearchField(controller: searchController),
      ),
    );
  }
}
