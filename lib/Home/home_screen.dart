import 'package:flutter/material.dart';
import 'package:gps_maps/Location/my_location.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider myLocationProvider = LocationProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: ()
                {
                  getUsersLocation();
                }, child: const Text('Get Location Data'))
          ],
        ),
      ),
    );
  }

  void getUsersLocation()async
  {
    var locationData =await  myLocationProvider.getLocation();

    print(locationData?.latitude);
    print(locationData?.longitude);
    print(locationData?.accuracy);
    print(locationData?.provider);
    print(locationData?.time);

    myLocationProvider.trackUserLocation().listen((newLocation)
    {
      print(newLocation.latitude);
      print(newLocation.longitude);
      print(newLocation.accuracy);
      print(newLocation.provider);
      print(newLocation.time);

    });
  }

}
