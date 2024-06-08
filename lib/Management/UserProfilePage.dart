import 'dart:convert';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:lite_harvest/Management/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  // final String userName;

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<SensorData> sensorData = [];
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = '';

  final int dataLimit = 10; //limit the number of values plotted

  // timer for realtime update
  Duration pollingDuration = Duration(seconds: 5); // Adjust polling interval
  Timer? pollingTimer;
  StreamSubscription<DatabaseEvent>? databaseSubscription;

  Query ref = FirebaseDatabase.instance.ref().child('sensorData');

  Future<String> getDataFromFirebase() async {
    String url =
        'https://liteharvest-68d43-default-rtdb.firebaseio.com/sensorData.json';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadSensorData() async {
    final String jsonString = await getDataFromFirebase();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      sensorData.add(SensorData.fromJson(i));
    }
    // Maintain data limit by removing older entries after fetching new data
    if (sensorData.length > dataLimit) {
      sensorData.removeRange(0, sensorData.length - dataLimit);
    }
  }

  @override
  void initState() {
    super.initState();
      // Check if user is logged in
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      // User not logged in, redirect to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginManage()),
      );
      return;
    } else {
      // userName = currentUser.displayName ?? currentUser.email ?? '';
      userName = currentUser.displayName ?? "";
      if (userName.isEmpty) {
      // If display name is empty, try to get name from Firestore
      getUserData(currentUser.uid);
      }
    }
    loadSensorData();
    pollingTimer = Timer.periodic(pollingDuration, (_) => loadSensorData());

    // Event listener approach:

    databaseSubscription = ref.onChildAdded.listen((DatabaseEvent event) {
      // Cast the event.snapshot.value to a Map<String, dynamic>
      final Map<String, dynamic> newSensorData =
          event.snapshot.value as Map<String, dynamic>;
      sensorData.add(SensorData.fromJson(newSensorData));
      _handleNewSensorData(newSensorData);
    });
    super.initState();
  }

  @override
  void dispose() {
    pollingTimer?.cancel();
    databaseSubscription?.cancel();
    // Unsubscribe from the listener when the UI is no longer active
      //  _databaseRef.onChildAdded.cancel();
    super.dispose();
  }

  void _handleNewSensorData(Map<String, dynamic> newSensorData) {
       // Process new data and potentially trigger notification here
       // ... (Logic to update UI or trigger notification)

       // Example: Show a basic notification (consider using a notification library for more advanced visuals)
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               content: Text('New sensor data received!'),
               duration: Duration(seconds: 5),
           )
       );
   }

  Future<void> getUserData(String userId) async {
    final docRef = firestore.FirebaseFirestore.instance.collection('users').doc(userId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final userData = docSnapshot.data();
      setState(() {
      userName = userData!['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,
          actions: [
          IconButton(
            onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginManage()), // Redirect to login page
                    );
                 }, 
            icon: Icon(Icons.logout),
          )
        ],
        ),
        body: FutureBuilder(
            future: getDataFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final limitedData = sensorData.sublist(
                    sensorData.length - dataLimit, sensorData.length);
                // Get the latest sensor data
                final latestData = sensorData.isNotEmpty ? sensorData.last : null;
                return (Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Welcome! $userName', // Display user's name
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            title: AxisTitle(text: 'TDS'),
                          ),
                          primaryYAxis: NumericAxis(
                            title: AxisTitle(text: 'EC'),
                          ),
                          title: ChartTitle(text: 'TDS VS EC'),
                          series: <LineSeries>[
                            LineSeries<SensorData, String>(
                              dataSource: limitedData,
                              xValueMapper: (SensorData data, _) =>
                                  data.tds.toStringAsFixed(2),
                              yValueMapper: (SensorData data, _) => double.parse(data.ec.toStringAsFixed(2)),
                            ),
                            LineSeries<SensorData, String>(
                              dataSource: limitedData,
                              xValueMapper: (SensorData data, _) =>
                                  data.tds.toStringAsFixed(2),
                              yValueMapper: (SensorData data, _) => 2.2,
                            ),
                          ]),
                          SizedBox(height: 10),
                          Text('Latest Values\n'),
                          Text('Temperature: ${latestData?.temperature.toStringAsFixed(2) ?? 'NA'}°C'),
                          Text('TDS: ${latestData?.tds.toStringAsFixed(2) ?? 'NA'} ppm'),
                          Text('EC: ${latestData?.ec.toStringAsFixed(2) ?? 'NA'} μS/cm'),
                    ],
                  ),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class SensorData {
  SensorData(this.temperature, this.tds, this.ec);
  final double temperature;
  final double tds;
  final double ec;

  factory SensorData.fromJson(Map<String, dynamic> parsedJson) {
    return SensorData(parsedJson['Temperature'], parsedJson['TDS'], parsedJson['EC']);
  }
}
