import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWeather(),
      title: "Flutter Weather",
    );
  }
}

class HomeWeather extends StatefulWidget {
  @override
  _HomeWeatherState createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  var temp;
  var desc;
  var cur;
  var hum;
  var wind;
  var loc;
  var city;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q={yourLocation}&appid={yourApiKey}");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.desc = results['weather'][0]['description'];
      this.cur = results['weather'][0]['main'];
      this.hum = results['main']['humidity'];
      this.wind = results['wind']['speed'];
      this.loc = results['sys']['country'];
      this.city = results['name'];
    });
  }

  // this method for get weather
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff7D95FB), Color(0xffD48BFB)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            city != null ? city.toString() : "loading",
                            style: GoogleFonts.raleway(
                                color: Colors.yellow,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          loc != null ? loc.toString() : "loading",
                          style: GoogleFonts.raleway(
                              color: Colors.yellow,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: GoogleFonts.raleway(
                      color: Colors.yellow,
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      cur != null ? desc.toString() : "Loading",
                      style: GoogleFonts.raleway(
                          color: Color(0xff202040),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometer,
                          color: Color(0xffD48BFB)),
                      title: Text(
                        "Temperature",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202040),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading",
                        style: GoogleFonts.raleway(
                          color: Color(0xff202040),
                          fontSize: 15.0,
                        ),
                      )),
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud,
                          color: Color(0xffD48BFB)),
                      title: Text(
                        "Cloud",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202040),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        temp != null ? desc.toString() : "Loading",
                        style: GoogleFonts.raleway(
                          color: Color(0xff202040),
                          fontSize: 15.0,
                        ),
                      )),
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun,
                          color: Color(0xffD48BFB)),
                      title: Text(
                        "Humadity",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202040),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        temp != null ? hum.toString() : "Loading",
                        style: GoogleFonts.raleway(
                          color: Color(0xff202040),
                          fontSize: 15.0,
                        ),
                      )),
                  ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind,
                          color: Color(0xffD48BFB)),
                      title: Text(
                        "Wind Speed",
                        style: GoogleFonts.raleway(
                            color: Color(0xff202040),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        temp != null ? wind.toString() : "Loading",
                        style: GoogleFonts.raleway(
                          color: Color(0xff202040),
                          fontSize: 15.0,
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
