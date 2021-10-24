// fetch data from the internet : as http package 라고 하기 위해 alias 사용
import 'package:http/http.dart' as http;

// jsonDecode 사용을 위한 convert import
import 'dart:convert';

class FetchData {
  // current API call variable
  final String url;

  // AirPolution call variable
  final String url2;

  // constructor
  FetchData(this.url, this.url2);

  // json 의 타입은 다양하기 때문에 dynamic 으로 type 설정
  // Get Json data from current API
  Future<dynamic> getJsonData() async {
    // fetch data
    final response = await http.get(Uri.parse(url));
    // response data 가 성공적으로 받아 올경우 200 code 임 : String type 으로 변환
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  // Get Json data from Air Pollution API
  Future<dynamic> getAirData() async {
    // fetch data
    final response = await http.get(Uri.parse(url2));
    // response data 가 성공적으로 받아 올경우 200 code 임 : String type 으로 변환
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
