import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyAVLTGiMQzxgYBYnviizjkO9g-HRLIEMH4';

class LocationHelper {
  static String generateLoactionPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:b%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    // &signature=YOUR_SIGNATURE
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAVLTGiMQzxgYBYnviizjkO9g-HRLIEMH4");

    final response = await http.get(url);
    // return jsonDecode(response.body)['result'][0]['formatted_data'];
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
