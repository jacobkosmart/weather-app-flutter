import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:wearther_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  // 다양한 type 의 날씨 data 를 전달 받아야 되기 때문에 dynamic type 설정
  final dynamic parseWeatherData;
  final dynamic parseAirData;

  // constructor named argument 를 전달 받아야 하기 때문에 {} 안에 넣어야 됨
  const WeatherScreen({Key? key, this.parseWeatherData, this.parseAirData})
      : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // model instance 생성
  Model model = Model();

  // variables
  String? cityName;
  int? temp;
  var date = DateTime.now();
  Widget? icon;
  String? description;
  Widget? airIcon;
  Widget? airState;
  double? dust1;
  double? dust2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // A State object's configuration is the corresponding StatefulWidget instance. : 즉 위의 WeatherScreen 의 속성 값을 가지고 오려면 widget. 하고 get implement 할 수 있다
    updateState(widget.parseWeatherData, widget.parseAirData);
  }

  void updateState(dynamic weatherData, dynamic airData) {
    // 현재 도시 이름 fetchWeatherData name
    cityName = weatherData['name'];
    // 현재 기온 fetchWeatherData temp
    // 소수점을 없에기 위해 변수 하나 더 만들어서 .toInt() 해줌
    double doubleTemp = weatherData['main']['temp'];
    temp = doubleTemp.toInt();
    // 현재 날씨 상태 fetchWeatherData id
    int condition = weatherData['weather'][0]['id'];
    // 현재 날씨 상태 icon
    icon = model.getWeatherIcon(condition);
    // 현재 날씨 상태 fetchWeatherData description
    description = weatherData['weather'][0]['description'];
    // 대기질 지수 fetchAirData aqi index
    int index = airData['list'][0]['main']['aqi'];
    // 대기질 지수 아이콘 과 text 변수
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    // dust1: 미세먼지 변수값 , dust2 : 초미세먼지 변수값
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
  }

  String getSystemTime() {
    var now = DateTime.now();
    // DateFormat 을 받기 위해 intl 0.17. package 사용
    return DateFormat("h:mm a").format(now);
  }

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
          onPressed: () {
            Restart.restartApp();
          },
          icon: Icon(Icons.near_me),
          iconSize: 30.0,
          padding: const EdgeInsets.all(20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Restart.restartApp();
            },
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
              'images/background2.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // city name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 150.0),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            // 시간 요일 날짜 연도 표시
                            Row(
                              children: <Widget>[
                                // 1분 단위로 시간 표시
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)),
                                  builder: (context) {
                                    return Text(
                                      getSystemTime(),
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: Colors.white),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // 날씨 정보
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 온도 에 섭씨 기온 유니코드로 표시함
                              '$temp \u2103',
                              style: GoogleFonts.lato(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  description as String,
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '대기질 지수',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              airIcon as Widget,
                              SizedBox(height: 10),
                              airState as Widget,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '$dust1',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '㎍/m³',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '㎍/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
