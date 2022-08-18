import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = '';
  String time = '';
  String flag = '';
  String uri = '';
  bool? isDayTime;

  // Constructor ==> how the Class should be called
  WorldTime({required this.location, required this.flag, required this.uri});

  Future<void> getTime() async {
    //make the response
    try {
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$uri'));
      final data = await jsonDecode(response.body);

      // getting properties
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'];

      String hours = offset.substring(1, 3);
      String minutes = offset.substring(4);

      // print(datetime);
      // print(offset);

      // create DateTime object
      final now = DateTime.parse(datetime);
      final newTime = now
          .add(Duration(hours: int.parse(hours), minutes: int.parse(minutes)));
      // time = newTime.toString(); // Set the time property
      isDayTime = newTime.hour > 6 && newTime.hour < 20 ? true : false;
      time = DateFormat.jm().format(newTime);
    } catch (e) {
      time = "Could not get time data";
    }
  }
}

// how we can create an instance of a class
// WorldTime instance =
//     WorldTime(location: 'Berlin', flag: 'germany.png', uri: 'Europe/Berlin');

// instance.getTime();