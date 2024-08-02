import 'package:connectun_vpn/constants/colors.dart';
import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.name,
    required this.icon,
    required this.isActive,
  });
  final String name;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          isActive
              ? Positioned(
                  height: 56,
                  width: 270,
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              : const SizedBox(),
          ListTile(
            onTap: () {},
            leading: SizedBox(
              height: 34,
              width: 34,
              child: Icon(
                icon,
                color: GlobalColor.white,
              ),
            ),
            title: Text(
              name,
              style: TextStyle(color: GlobalColor.white),
            ),
          ),
        ],
      ),
    );
  }
}
