import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Django App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeviceList(),
    );
  }
}

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List devices = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDevices();
  }

  fetchDevices() async {
    final url = 'http://localhost:8000/api/devices/'; // Update this if necessary
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          devices = json.decode(response.body);
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load devices: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching devices: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device List'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  title: Text(device['name']),
                  subtitle: Text(device['location']),
                );
              },
            ),
    );
  }
}
