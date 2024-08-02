import 'package:connectun_vpn/constants/colors.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.location,
  });

  final String name, location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person_outline,
          color: GlobalColor.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: GlobalColor.white),
      ),
      subtitle: Text(
        location,
        style: TextStyle(color: GlobalColor.white),
      ),
    );
  }
}
