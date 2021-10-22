import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';

class WeatherScreen extends StatefulWidget {
  // 다양한 type 의 날씨 data 를 전달 받아야 되기 때문에 dynamic type 설정
  final dynamic parseWeatherData;

  // constructor named argument 를 전달 받아야 하기 때문에 {} 안에 넣어야 됨
  const WeatherScreen({Key? key, this.parseWeatherData}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // 값을 받기 위한 변수
  String? cityName;
  int? temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // A State object's configuration is the corresponding StatefulWidget instance. : 즉 위의 WeatherScreen 의 속성 값을 가지고 오려면 widget. 하고 get implement 할 수 있다
    updateState(widget.parseWeatherData);
  }

  void updateState(dynamic weatherData) {
    cityName = weatherData['name'];
    // 소수점을 없에기 위해 변수 하나 더 만들어서 .toInt() 해줌
    double doubleTemp = weatherData['main']['temp'];
    temp = doubleTemp.toInt();
    print(cityName);
    print(temp);
  }

  // String getSystemTime() {
  //   var now = DateTime.now();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body 부분을 appBar 까지 확장
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        // 음영 0으로 처리
        elevation: 0,
        // appBar 투명 처리
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.near_me),
          iconSize: 30.0,
          padding: const EdgeInsets.all(20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            iconSize: 30.0,
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            // 배경화면 설정
            Image.asset(
              'images/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 150.0),
                  Text(
                    '$cityName',
                    style: GoogleFonts.lato(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                  // Row(
                  //   children: <Widget>[
                  //     TimerBuilder.periodic(Duration(minutes: 1), builder: (context) {

                  //     },),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
