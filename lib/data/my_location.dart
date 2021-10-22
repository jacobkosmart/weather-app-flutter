// 현재 위치 상태를 파악하기 위한 package
import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? currentLatitude;
  double? currentLongitude;

  // Futer 값으로 바꿔줘야지 instance 의 await 이 작동을 함
  Future<void> getMyCurrentLocation() async {
    // GPS 로 나의 위치를 파악하는 position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print('current_latitude : $currentLatitude');
      print('current_longitude : $currentLongitude');
    } catch (e) {
      print('There was a problem with the Internet connection');
    }
  }
}
