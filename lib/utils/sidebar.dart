import 'package:connectun_vpn/constants/colors.dart';
import 'package:connectun_vpn/widgets/info_card.dart';
import 'package:connectun_vpn/widgets/side_menu_tile.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 288,
        height: double.infinity,
        color: GlobalColor.secondary,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: 'Crescent Mnyama',
                location: 'Dar es Salaam',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Menu'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white24,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, bottom: 16, right: 24),
                child: Divider(
                  color: Colors.white24,
                  height: 1,
                ),
              ),
              const SideMenuTile(
                name: 'Home',
                icon: Icons.home,
                isActive: true,
              ),
              const SideMenuTile(
                name: 'Community',
                icon: Icons.messenger_rounded,
                isActive: false,
              ),
              const SideMenuTile(
                name: 'Logs',
                icon: Icons.notes_rounded,
                isActive: false,
              ),
              const SideMenuTile(
                name: 'Rate us',
                icon: Icons.favorite,
                isActive: false,
              ),
              const SideMenuTile(
                name: 'Tell a friend',
                icon: Icons.share,
                isActive: false,
              ),
              const SideMenuTile(
                name: 'Contact us',
                icon: Icons.contact_mail,
                isActive: false,
              ),
              const SideMenuTile(
                name: 'About ',
                icon: Icons.help,
                isActive: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
