import 'package:connectun_vpn/constants/colors.dart';
import 'package:connectun_vpn/widgets/server_container.dart';
import 'package:flutter/material.dart';

class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});

  @override
  State<ServersScreen> createState() => _ServersScreenState();
}

class _ServersScreenState extends State<ServersScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true;
  late Map<String, Map<String, String>> countryDetails;
  late Map<String, Map<String, String>> freeServers;
  late Map<String, Map<String, String>> premiumServers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    countryDetails =
        arguments['countryDetails'] as Map<String, Map<String, String>>;

    // Filtering servers by type
    freeServers = countryDetails.entries.where((entry) {
      // print('Checking ${entry.key}: ${entry.value}');
      return entry.value['Type']?.trim() == 'free';
    }).fold({}, (prev, entry) {
      prev[entry.key] = entry.value;
      return prev;
    });

    premiumServers = countryDetails.entries.where((entry) {
      // print('Checking ${entry.key}: ${entry.value}');
      return entry.value['Type']?.trim() == 'premium';
    }).fold({}, (prev, entry) {
      prev[entry.key] = entry.value;
      return prev;
    });

    // print('Free Servers: $freeServers');
    // print('Premium Servers: $premiumServers');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.secondary,
      appBar: AppBar(
        title: const Text('Change Location'),
        backgroundColor: Colors.transparent,
        foregroundColor: GlobalColor.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: BackButton(
          color: GlobalColor.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : countryDetails.isEmpty
              ? const Center(child: Text('No servers data available'))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: GlobalColor.white,
                          ),
                          cursorWidth: 1.25,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded),
                            prefixIconColor: GlobalColor.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusColor: GlobalColor.white,
                            hintText: 'Search server here...',
                            hintStyle: TextStyle(
                              color: GlobalColor.muted,
                              fontWeight: FontWeight.normal,
                            ),
                            hoverColor: GlobalColor.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                          ),
                          cursorColor: GlobalColor.muted,
                          enableSuggestions: true,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        Text(
                          'Automatic server',
                          style: TextStyle(
                            color: GlobalColor.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        const ServerContainer(
                          country: 'Tanzania',
                          flag: 'assets/flags/tz.png',
                          isConnected: true,
                        ),
                        // Free Servers
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        Text(
                          'Free Servers',
                          style: TextStyle(
                            color: GlobalColor.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        ...freeServers.entries.map((entry) {
                          final countryCode = entry.key;
                          final details = entry.value;
                          final name = details['Name'] ?? 'Unknown';

                          return ServerContainer(
                            country: name,
                            flag:
                                'assets/flags/${countryCode.toLowerCase()}.png',
                            isConnected: false,
                            serverValue:
                                freeServers.keys.toList().indexOf(countryCode) +
                                    1,
                          );
                        }).toList(),
                        // Premium Servers
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        Text(
                          'Premium Servers',
                          style: TextStyle(
                            color: GlobalColor.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        ...premiumServers.entries.map((entry) {
                          final countryCode = entry.key;
                          final details = entry.value;
                          final name = details['Name'] ?? 'Unknown';

                          return ServerContainer(
                            country: name,
                            flag:
                                'assets/flags/${countryCode.toLowerCase()}.png',
                            isConnected: false,
                            serverValue:
                                premiumServers.keys.toList().indexOf(countryCode) +
                                    1,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
    );
  }
}
