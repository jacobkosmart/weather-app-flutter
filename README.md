# wearther_app

## Version

- v.1.0.0 : Android PlayStore App 출시 버전

## 설치 페키지

## Check Point !

### geolocator

> (gelocator package)[https://pub.dev/packages/geolocator]

- 현재 위치 정보를 가지고 올수 있는 package 입니다

#### 데이터 가져오기

```dart
import 'package:geolocator/geolocator.dart';

// GPS 로 나의 위치를 파악하는 position
Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
```

- App 에서 나의 위치 정보를 사용하려면 반드시 동의 과정을 거쳐야 되기 때문에 각 device 마다 따로 설정을 해줘야 함

#### Android 설정

- 프로젝트 내에서 `android/app/src/main/AndroidManifest.xml` 파일 안에 <manifest> 테그 안에 붙여 넣기 합니다

```xml

<!-- Internet Permission -->
<uses-permission android:name="android.permission.INTERNET" />

<!-- Location Permission -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

- 위의 작업을 하고 다음과 같은 error 가 발생하면 android compileSDKversion 을 다음과 같이 바꿔 줘야 합니다

> (Execution failed for task ‘:geolocator_android:compileDebugJavaWithJavac’ in flutter)[https://fluttercorner.com/execution-failed-for-task-geolocator_androidcompiledebugjavawithjavac-in-flutter/]

```gradle
<!-- in android/app/build.gradle -->

android {

    compileSdkVersion 31
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 29
    }
}
```

그리고 `gradle.properties` 에서 다음과 같이 설정해줍니다

```gradle
android.useAndroidX=true
android.enableJetifier=true
```

#### iOS 설정

- 프로젝트 내에 `ios/Runner/info.plist` 안에 `dict` 테그 안에 다음의 코드를 붙여 넣습니다

```plist
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>
```

### initState()

- 대부분의 날씨 앱은 사용자가 자기의 위치를 켜자 마자 자동으로 위치를 가져 와서 내가 있는 지역에 날씨 데이터를 보여주게 됩니다. 앱을 시작하자 마자 경도와 위도 위치 정보 가져오기

```dart
// in loading.dart

  @override
  // loding 이라는 stateful widget 이 생성되는 순간에 딱 한번만 호출되는 method
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
```

### try , catch

- 사용자가 위치를 deny 하거나, internet, gps 가 잡히지 않아 위치 정보를 가져오지 못하는 경우에는 app 이 충돌되거나, freezing 될 수 있기 때문에 `try catch` 를 사용해서 실패 경우할 경우도 지정해줘야 합니다

```dart
 void getLocation() async {
    // GPS 로 나의 위치를 파악하는 position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } catch (e) {
      print('There was a problem with the Internet connection');
    }
  }
```

#### HTTP package (fetch data)

> [Http Package](https://pub.dev/packages/http)

> [fetch data from the internet](https://flutter.dev/docs/cookbook/networking/fetch-data)

```dart
// in loading.dart

// fetch data from the internet : as http package 라고 하기 위해 alias 사용
import 'package:http/http.dart' as http;

// jsonDecode 사용을 위한 convert import
import 'dart:convert';

  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }


  void fetchData() async {
    // fetch data
    final response = await http.get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
    // response data 가 성공적으로 받아 올경우 200 code 임 : String type 으로 변환
    if (response.statusCode == 200) {
      String jsonData = response.body;

      // jsonDecode를 통해서 원하는 데이터 값 가져오기
      var id = jsonDecode(jsonData)['id'];
      var description = jsonDecode(jsonData)['weather'][0]['description'];
      print(id);
      print(description);
    }
  }
```

![image](https://user-images.githubusercontent.com/28912774/138393987-793b6291-3aea-4fe8-9266-334ac23499d1.png)

### timer_builder 2.0.0 package : 현재 시간 불러 오는 package

### : data format 객체로 return 하기 위한 package

```dart

import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

String getSystemTime() {
  var now = DateTime.now();
  // DateFormat 을 받기 위해 intl 0.17. package 사용
  return DateFormat("h:mm a").format(now);
}


```

- Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

> [intl Package](https://pub.dev/packages/intl/install)

## reference

Flutter cookbook - [https://flutter.dev/docs/cookbook](https://flutter.dev/docs/cookbook)

geolocator package - [https://pub.dev/packages/geolocator](https://pub.dev/packages/geolocator)

http package - [https://pub.dev/packages/http](https://pub.dev/packages/http)

코딩 셰프 - [https://youtu.be/YqKMBQYZSmw](https://youtu.be/YqKMBQYZSmw)
