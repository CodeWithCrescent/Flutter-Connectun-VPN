import 'package:connectun_vpn/constants/colors.dart';
import 'package:connectun_vpn/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectun VPN Tunnel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalColor.primary),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
