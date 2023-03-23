import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_maps/Location/my_location.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider myLocationProvider = LocationProvider();
  CameraPosition cameraPosition = const CameraPosition(target: LatLng(30.0816738,31.0184049),zoom: 15,tilt: 2);
  GoogleMapController? googleMapController = null;
  @override
  void initState() {
    super.initState();
    trackUsersLocation();
  }
  static const String markerID = '';
Set<Marker> marker = {
    const Marker(markerId: MarkerId(markerID),position:  LatLng(30.0816738,31.0184049),),
};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller)
              {
                googleMapController = controller;
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              markers: marker,
              onTap: (latLng)
              {
                print(latLng);
              },
              onLongPress: (latLng)
              {
                print(latLng);
              },
            ),
          ),
        ],
      ),
    );
  }

  static const String userMarkerID = 'USER';

  StreamSubscription<LocationData>? locationSubscription = null;

  void trackUsersLocation()async
  {
    var locationData =await  myLocationProvider.getLocation();

    print(locationData?.latitude);
    print(locationData?.longitude);
    print(locationData?.accuracy);
    print(locationData?.provider);
    print(locationData?.time);

    myLocationProvider.locationManager.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 2000,
      distanceFilter: 10,

    );
    myLocationProvider.trackUserLocation().listen((newLocation)
    {
      print(newLocation.latitude);
      print(newLocation.longitude);
      print(newLocation.accuracy);
      print(newLocation.provider);
      print(newLocation.time);
      Marker userMarker = Marker(markerId: const MarkerId(userMarkerID),
        position: LatLng(newLocation.latitude ?? 0.0, newLocation.longitude ?? 0.0),
      );
      marker.add(userMarker);

      CameraUpdate.newLatLngZoom(LatLng(newLocation.latitude ?? 0.0, newLocation.longitude ?? 0.0), 15,);
      setState(() {});

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationSubscription?.cancel();
  }

}