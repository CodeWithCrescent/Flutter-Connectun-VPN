import 'package:connectun_vpn/constants/colors.dart';
import 'package:flutter/material.dart';

Future<void> showTryPremiumBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: GlobalColor.secondary,
    isDismissible: true,
    elevation: 5,
    showDragHandle: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height / 1.75,
      child: Column(
        children: [
          Text(
            'Choose your plan',
            style: TextStyle(
              color: GlobalColor.white,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  planTile(
                    1,
                    'Weekly',
                    'Pay weekly, cancel anytime',
                    GlobalColor.black,
                    GlobalColor.white,
                    false,
                    GlobalColor.primary,
                    GlobalColor.white,
                  ),
                  planTile(
                    2,
                    'Monthly',
                    'Pay monthly, cancel anytime',
                    GlobalColor.black,
                    GlobalColor.white,
                    false,
                    GlobalColor.primary,
                    GlobalColor.white,
                  ),
                  planTile(
                    3,
                    'Yearly',
                    'Pay for a full year',
                    GlobalColor.white,
                    GlobalColor.primary,
                    true,
                    GlobalColor.white,
                    GlobalColor.black,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(GlobalColor.white),
                        backgroundColor:
                            MaterialStateProperty.all(GlobalColor.secondary),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide(color: GlobalColor.primary),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15),
                        ),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(MediaQuery.of(context).size.width),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: GlobalColor.white,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Container planTile(
    int? selectedTile,
    String title,
    String subtitle,
    Color textColor,
    Color tileColor,
    bool selected,
    Color badgeColor,
    Color badgeTextColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    margin: const EdgeInsets.only(bottom: 20.0),
    child: RadioListTile<int>(
      value: 1,
      groupValue: selectedTile,
      onChanged: (int? value) {
        selectedTile = value;
      },
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      toggleable: true,
      subtitle: Text(subtitle),
      tileColor: tileColor,
      activeColor: textColor,
      selectedTileColor: GlobalColor.primary,
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      secondary: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Tsh. 2673.89'),
          const SizedBox(height: 10),
          Badge(
            backgroundColor: badgeColor,
            textColor: badgeTextColor,
            label: const Text('Save 20%'),
          )
        ],
      ),
    ),
  );
}
