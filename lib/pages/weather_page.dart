import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('473556b36e6701d78fc22b200c841fae');
  Weather? _weather;



  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
        final weather = await _weatherService.getWeather(cityName);
        setState((){
          _weather =weather;
        });
      }
      catch(e){
        print(e);
      }
    }
  

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..."),
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      )
    );
  }
}