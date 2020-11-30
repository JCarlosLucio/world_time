import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // location name for UI
  String time; // time in that location for UI
  String flag; // url to assets Flag Icon
  String url; // location url for API endpoint

  // constructor for named parameters
  // used like this WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
  WorldTime({this.location, this.flag, this.url});

  // Future type (works like JS promises)
  Future<void> getTime() async {
    try {
      // // Response type / get() function given by http package
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      // // jsonDecode from convert package
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      // offset is the hours needed to reach the accurate time (+01:00)
      // used substring to get '01'
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // create DateTime object (comes with dart)
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      time = now.toString();
    } catch (error) {
      print('a wild error appeared: $error');
      // avoids passing a null object to time
      time = 'Could not get time data :(';
    }
  }
}