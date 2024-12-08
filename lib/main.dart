import 'package:flutter/material.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:photo_editor_app/providers/theme_provider.dart';
import 'package:photo_editor_app/screens/home_screen.dart';
import 'package:photo_editor_app/screens/splash_screen.dart'; // إضافة استيراد شاشة البداية
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageProviderModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashWrapper(), // استبدال شاشة البداية هنا
    );
  }
}

class SplashWrapper extends StatefulWidget {
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    // الانتقال إلى شاشة ImageEditorScreen بعد 3 ثوانٍ
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ImageEditorScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // شاشة البداية
  }
}
