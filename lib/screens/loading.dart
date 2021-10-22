import 'package:flutter/material.dart';
import 'package:wearther_app/data/fetch_data.dart';
import 'package:wearther_app/data/my_location.dart';
import 'package:wearther_app/screens/weather_screen.dart';

// open weather api keys
const apiKey = '30fc75c0bb077ef7da64673745312047';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double newLatitude;
  late double newLongitude;

  @override
  // loding 이라는 stateful widget 이 생성되는 순간에 딱 한번만 호출되는 method
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    // my location instance 생성

    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    newLatitude = myLocation.currentLatitude!;
    newLongitude = myLocation.currentLongitude!;

    print('current2_latitude : $newLatitude');
    print('current2_longitude : $newLongitude');

    // fetch data instance 생성
    FetchData fetchData = FetchData(
        'https://api.openweathermap.org/data/2.5/weather?lat=$newLatitude&lon=$newLongitude&appid=$apiKey&units=metric');

    var weatherData = await fetchData.getJsonData();
    // print('weatherData : $weatherData');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(parseWeatherData: weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
