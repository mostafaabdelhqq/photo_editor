import 'package:flutter/material.dart';
import 'package:photo_editor_app/providers/image_provider.dart';
import 'package:photo_editor_app/providers/theme_provider.dart';
import 'package:photo_editor_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

// استيراد Provider الخاص بنا

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
        brightness: Brightness.light, // الوضع النهاري
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // الوضع الليلي
      ),
      debugShowCheckedModeBanner: false,
      home: ImageEditorScreen(),
    );
  }
}
