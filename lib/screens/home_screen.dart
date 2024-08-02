import 'package:connectun_vpn/constants/colors.dart';
import 'package:connectun_vpn/screens/servers_screen.dart';
import 'package:connectun_vpn/services/countries_service.dart';
import 'package:connectun_vpn/utils/sidebar.dart';
import 'package:connectun_vpn/widgets/bottom_sheet.dart';
import 'package:connectun_vpn/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, Map<String, String>>? countryDetails;
  bool isLoading = true;
  bool _isConnected = false;
  bool _isWaitingToConnect = false;

  @override
  void initState() {
    super.initState();
    _loadCountryDetails();
  }

  Future<void> _loadCountryDetails() async {
    try {
      CountryService countryService = CountryService();
      Map<String, Map<String, String>> details =
          await countryService.getCountryDetails();
      setState(() {
        countryDetails = details;
        isLoading = false;
      });
    } catch (error) {
      print("Error loading country details: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: GlobalColor.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('Aero VPN'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        // leading: const Icon(Icons.grid_view_rounded),
      ),
      drawer: const SideBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: GlobalColor.white))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        Text(
                          _isConnected
                              ? 'You are connected 🇺🇸'
                              : 'You are not connected',
                          style: TextStyle(
                            fontSize: 22,
                            color: GlobalColor.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'IP: 178.43.27.90',
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 0,
                            color: GlobalColor.primary,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 12),
                        GestureDetector(
                          onTap: () {
                            if (!_isConnected) {
                              final snackAlert = SnackBar(
                                content: const Text(
                                    'This may take up to 15 seconds to connect.'),
                                backgroundColor: GlobalColor.primary,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackAlert);

                              setState(() {
                                _isWaitingToConnect = true;
                              });
                            }

                            // Delay the state update by 5 seconds
                            Future.delayed(
                                _isConnected
                                    ? const Duration(milliseconds: 100)
                                    : const Duration(seconds: 5), () {
                              setState(() {
                                _isConnected = !_isConnected;
                                _isWaitingToConnect = false;
                              });
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 4.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width / 2),
                              color: _isConnected
                                  ? GlobalColor.primary
                                  : GlobalColor.white,
                              boxShadow: [
                                BoxShadow(
                                  color: GlobalColor.primary,
                                  blurRadius: 50,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                              border: Border.all(
                                color: _isConnected
                                    ? GlobalColor.primary
                                        .withBlue(220)
                                        .withGreen(90)
                                    : GlobalColor.primary,
                                width: 12,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isWaitingToConnect
                                    ? SpinKitRipple(
                                        color: GlobalColor.primary,
                                        size: 75.0,
                                      )
                                    : Image.asset(
                                        'assets/icons/power_icon.png',
                                        width: 75,
                                        color: _isConnected
                                            ? GlobalColor.white
                                            : GlobalColor.primary,
                                      ),
                                const SizedBox(height: 3),
                                Text(
                                  _isConnected
                                      ? 'CONNECTED'
                                      : _isWaitingToConnect
                                          ? 'CONNECTING...'
                                          : 'START',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: _isConnected
                                        ? GlobalColor.white
                                        : GlobalColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10),
                        GestureDetector(
                          onTap: () {
                            _isConnected
                                ? showCustomDialog(context)
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ServersScreen(),
                                      settings: RouteSettings(
                                        arguments: {
                                          'countryDetails': countryDetails
                                        },
                                      ),
                                    ),
                                  );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: GlobalColor.primary,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 25,
                              vertical: MediaQuery.of(context).size.height / 85,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '🔥',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    // ClipOval(
                                    //   child: Image.network(
                                    //     'https://flagsapi.com/US/flat/64.png',
                                    //     width: 40,
                                    //     height: 40,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    Text(
                                      'Any Optimized',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: GlobalColor.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 40),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: GlobalColor.white,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10),
                        GestureDetector(
                          onTap: () {
                            showTryPremiumBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: GlobalColor.primary,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 25,
                              vertical: MediaQuery.of(context).size.height / 85,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/crown_icon.png',
                                  width: MediaQuery.of(context).size.width / 18,
                                  color: GlobalColor.white,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 30),
                                Text(
                                  'TRY PREMIUM',
                                  style: TextStyle(
                                    color: GlobalColor.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
