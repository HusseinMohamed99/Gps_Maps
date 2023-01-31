import 'package:location/location.dart';

//
// Location location =  Location();
//
// bool _serviceEnabled;
// PermissionStatus _permissionGranted;
// LocationData _locationData;
//
// _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled) {
// _serviceEnabled = await location.requestService();
// if (!_serviceEnabled) {
// return;
// }
// }
//
// _permissionGranted = await location.hasPermission();
// if (_permissionGranted == PermissionStatus.denied) {
// _permissionGranted = await location.requestPermission();
// if (_permissionGranted != PermissionStatus.granted) {
// return;
// }
// }
//
// _locationData = await location.getLocation();
class LocationProvider
{
 Location locationManager = Location();

 Future<bool> isServicedEnable()async
  {
    var  servicedEnable =await locationManager.serviceEnabled();
    return servicedEnable;
  }

  Future<bool> requestServiced()async
  {
    var  servicedEnable =await locationManager.requestService();
    return servicedEnable;
  }

  Future<bool> isPermissionEnable()async
  {
    var  permissionStatus =await locationManager.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestPermission()async
  {
    var  permissionStatus =await locationManager.requestPermission();
    return permissionStatus == PermissionStatus.granted;
  }
 Future<LocationData?> getLocation()async
  {
    bool isServicedEnable =await requestServiced();
    bool isPermissionEnable =await requestPermission();
    if(!isServicedEnable || !isPermissionEnable)
    {
      return null;
    }
    return locationManager.getLocation();
  }

 Stream<LocationData> trackUserLocation()
 {
   return locationManager.onLocationChanged;
 }
}