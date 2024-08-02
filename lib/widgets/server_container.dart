import 'package:connectun_vpn/constants/colors.dart';
import 'package:flutter/material.dart';

class ServerContainer extends StatefulWidget {
  const ServerContainer({
    super.key,
    required this.country,
    required this.flag,
    required this.isConnected,
    this.serverValue,
  });

  final String country;
  final String flag;
  final bool isConnected;
  final int? serverValue;

  @override
  State<ServerContainer> createState() => _ServerContainerState();
}

class _ServerContainerState extends State<ServerContainer> {
  int? _selectedServer;

  @override
  void initState() {
    super.initState();
    // _selectedServer = widget.serverValue;
    print('INIT STATE: $_selectedServer');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: GlobalColor.muted,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  widget.flag,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 40),
              Text(
                widget.country,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  fontSize: 18,
                  color: GlobalColor.white,
                ),
              ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 40),
          widget.isConnected
              ? OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(GlobalColor.white),
                  ),
                  child: const Text('Connect'),
                )
              : Radio<int?>(
                  value: widget.serverValue,
                  groupValue: _selectedServer,
                  toggleable: true,
                  onChanged: (int? value) {
                    print('Current Selected Server: $_selectedServer');
                    setState(() {
                      print(
                          'Hii radio value: $value, Selected server: $_selectedServer');
                      _selectedServer = value;
                      print('Now tHE Selected server: $_selectedServer');
                    });
                  },
                  activeColor: GlobalColor.white,
                ),
        ],
      ),
    );
  }
}
