import 'package:flutter/material.dart';
import 'package:shophive/screens/auth/login_page.dart';
import 'package:shophive/utils/popup_helper.dart';
import 'package:shophive/widgets/stat_card.dart';
import 'package:shophive/widgets/menu_item.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onHomeTap;

  const ProfileScreen({
    super.key,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);
    const offWhite = Color(0xFFF8F4F0);

    // Dummy User data for now
    const String userName = 'Benard Oluchi';
    const String userEmail = 'oluchibenard3@gmail.com';
    const String userPhone = '+234 8079366087';

    // Get initials from name
    final initials = userName
    .split(' ')
    .map((e) => e[0])
    .take(2)
    .join()
    .toUpperCase();

    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        backgroundColor: offWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: deepBrown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Home button
                    GestureDetector(
                      onTap: () => onHomeTap?.call(),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: deepBrown,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: deepBrown,
                      ),
                    ),
                    // Edit profile button
                    GestureDetector(
                      onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: deepBrown,
                            size: 20,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              // USER AVATAR CIRCLE
              Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.08),
    blurRadius: 10,
    ),
    ],
    ),
    child: Row(
    children: [
      // initials circle
    Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
    color: deepBrown,
    shape: BoxShape.circle,
    ),
    child: Center(
    child: Text(
    initials,
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    ),
    ),
SizedBox(width: 16),

    // USER INFO
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
    userName,
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: deepBrown,
    ),
    ),
    SizedBox(height: 4),
    Text(
    userEmail,
    style: TextStyle(
    fontSize: 13,
    color: Colors.grey,
    ),
    ),
    SizedBox(height: 4),
    Text(
    userPhone,
    style: TextStyle(
    fontSize: 13,
    color: Colors.grey,
    ),
    ),
    ],
    ),
    ],
    ),
    ),
              SizedBox(height: 24),
    // STATS ROW
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
    children: [
      StatCard(value: '10', label: 'Orders', color: deepBrown),
    SizedBox(width: 12),
    StatCard(value: '5', label: 'Wishlist', color: amber),
    SizedBox(width: 12),
    StatCard(value: '10', label: 'Orders', color: deepBrown),
    ],
    ),
    ),
    SizedBox(height: 24),

    // MENU ITEMS
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.08),
    blurRadius: 10,
    ),
    ],
      ),
    child: Column(
    children: [
      MenuItem(
      icon: Icons.shopping_bag_outlined,
      label: 'My Orders',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey.shade100,
      ),
    MenuItem(
    icon: Icons.location_on_outlined,
    label: 'Saved Addresses',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
    height: 1,
    indent: 16,
    endIndent: 16,
    color: Colors.grey.shade100,
      ),
    MenuItem(
    icon: Icons.favorite_border,
    label: 'Wishlist',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey.shade100,
      ),
      MenuItem(
    icon: Icons.notifications_outlined,
    label: 'Notifications',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey.shade100,
      ),
      MenuItem(
    icon: Icons.settings_outlined,
    label: 'Settings',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey.shade100,
      ),
      MenuItem(
    icon: Icons.help_outline,
    label: 'Help & Support',
    onTap: () {},
    color: deepBrown,
    ),
      Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey.shade100,
      ),
    ],
    ),
    ),
    ),
     SizedBox(height: 24),

    // LOGOUT BUTTON
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
    onPressed: () {
    PopupHelper.showSuccessDialog(
    context,
    'Logout',
    'Are you sure you want to logout?',
    () {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (context) => LoginPage(),
    ),
    (route) => false,
    );
    },
    );
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade50,
    foregroundColor: Colors.red,
    elevation: 0,
    padding: EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(
    color: Colors.red.shade200,
    ),
    ),
    ),
    icon: Icon(
    Icons.logout,
    size: 20,
    ),
    label: Text(
    'Logout',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    ),
    SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  // STAT
}
