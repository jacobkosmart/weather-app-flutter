import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Model {
  // 각 날씨의 상태를 수치화 해서 수치에 맞는 svg image file 을 불러와야 하기 때문에 widget type 으로 만듬
  Widget? getWeatherIcon(int condition) {
    // 천둥 번개
    if (condition < 300) {
      return SvgPicture.asset(
        'svg/thunder.svg',
        height: 100,
        width: 100,
      );
    } else if (condition <= 501) {
      return SvgPicture.asset(
        'svg/rainy-3.svg',
        height: 100,
        width: 100,
      );
    } else if (condition < 502) {
      return SvgPicture.asset(
        'svg/rainy-5.svg',
        height: 100,
        width: 100,
      );
    } else if (condition <= 601) {
      return SvgPicture.asset(
        'svg/snowy-2.svg',
        height: 100,
        width: 100,
      );
    } else if (condition < 602) {
      return SvgPicture.asset(
        'svg/snowy-5.svg',
        height: 100,
        width: 100,
      );
    } else if (condition == 800) {
      return SvgPicture.asset(
        'svg/day.svg',
        height: 100,
        width: 100,
      );
    } else if (condition == 801) {
      return SvgPicture.asset(
        'svg/cloudy-day-2.svg',
        height: 100,
        width: 100,
      );
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'svg/cloudy.svg',
        height: 100,
        width: 100,
      );
    }
  }

  // 대기 질 지수에 따른 아이콘 변경 위젯생성
  Widget? getAirIcon(int index) {
    if (index == 1) {
      return Image.asset(
        'images/good.png',
        width: 37,
        height: 35,
      );
    } else if (index == 2) {
      return Image.asset(
        'images/fair.png',
        width: 37,
        height: 35,
      );
    } else if (index == 3) {
      return Image.asset(
        'images/moderate.png',
        width: 37,
        height: 35,
      );
    } else if (index == 4) {
      return Image.asset(
        'images/poor.png',
        width: 37,
        height: 35,
      );
    } else if (index == 5) {
      return Image.asset(
        'images/bad.png',
        width: 37,
        height: 35,
      );
    }
  }

  // 대기 질 지수에 따른 text condition 변경 위젯 생성
  Widget? getAirCondition(int index) {
    if (index == 1) {
      return Text(
        '"매우 좋음"',
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        '"좋음"',
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 3) {
      return Text(
        '"보통"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 4) {
      return Text(
        '"나쁨"',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 5) {
      return Text(
        '"매우 나쁨"',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
