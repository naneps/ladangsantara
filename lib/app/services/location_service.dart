import 'package:geocoding/geocoding.dart'
    as geocoding; // Import the geocoding package with a prefix.
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService extends GetxService {
  LocationData? locationData;
  String? completeAddress;

  Future<LocationData> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return locationData!;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return locationData!;
      }
    }

    locationData = await location.getLocation();
    // await getCompleteAddress();
    return locationData!;
  }

  Future<void> getCompleteAddress() async {
    if (locationData == null) {
      return;
    }

    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        locationData!.latitude!,
        locationData!.longitude!,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks.first;
        completeAddress = _buildCompleteAddress(placemark);
      }
    } catch (e) {
      print('Error getting complete address: $e');
    }
  }

  String _buildCompleteAddress(geocoding.Placemark placemark) {
    String street = placemark.street ?? '';
    String subLocality = placemark.subLocality ?? '';
    String locality = placemark.locality ?? '';
    String postalCode = placemark.postalCode ?? '';
    String country = placemark.country ?? '';

    return '$street, $subLocality, $locality, $postalCode, $country';
  }

  String get latitude => locationData?.latitude.toString() ?? '';
}
