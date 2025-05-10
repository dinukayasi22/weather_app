import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';



class WeatherService {

  static const BASE_URL = 'https://api.openweathermap.org/data/3.0/weather';
  final String apiKey;

  WeatherService(this.apiKey);
  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.altitude, position.latitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }

}