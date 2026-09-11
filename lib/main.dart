import 'package:flutter/material.dart';

import 'components/header/home_header.dart';
import 'models/user.dart';
import 'components/PAGE/HomePage.dart';

void main() {
  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HeaderTestPage extends StatelessWidget {
  const HeaderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    const user = User(
      id: 'user_001',
      username: 'wycliffe',
      displayName: 'Wycliffe',
      isVerified: true,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              currentUser: user,
              appName: 'Babangang',
              unreadNotifications: 4,
            ),

            const Expanded(
              child: Center(
                child: Text(
                  'Stories and feed will appear here',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}