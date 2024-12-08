import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق (يمكنك تغييره إذا أردت)
            Icon(
              Icons.photo_filter,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            // اسم التطبيق
            Text(
              'Photo Editor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // رسالة ترحيبية
            Text(
              'Edit your photos effortlessly!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
