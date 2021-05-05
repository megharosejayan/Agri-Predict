import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';
import 'package:agri_predict/components/urls.dart';

class AboutScreen extends StatefulWidget {
  final double data;

  const AboutScreen({Key key, this.data}) : super(key: key);
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color.fromARGB(100, 104, 159, 66),
    Color.fromARGB(100, 104, 159, 66),
    Color.fromARGB(100, 104, 159, 66)
  ],
).createShader(Rect.fromLTWH(100, 100, 100, 100));

class _AboutScreenState extends State<AboutScreen> {
  List<String> languages = ['English', 'മലയാളം'];
  String _selectedLanguage = 'മലയാളം';
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;
//Copyright widget

    Widget copyright = Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
    //Button section

    //Text widget

    Container textBuild(
      String text,
    ) {
      return Container(
        padding: const EdgeInsets.only(top: 0, bottom: 30),
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
          softWrap: true,
        ),
      );
    }
    // style

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * .19,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/head.png')),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(size.height * .05),
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.09,
                    margin: EdgeInsets.only(bottom: 20, left: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'FINAL RESULT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: size.height * 0.18, left: 20, right: 20),
            child: ListView(
              children: [
                Align(
                    child: Container(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01,
                            bottom: size.height * 0.01),
                        child: Text(
                          "THE PREDICTED CROP YIELD IS:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ))),
                Card(
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "RESULT : " + widget.data.toString() + " tonnes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 90, right: 90, bottom: 20),
                  child: RaisedButton(
                    elevation: 4,
                    color: Color.fromARGB(200, 254, 214, 56),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: const Text(
                      'BACK',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                copyright
              ],
            ),
          )
        ],
      ),
    );
  }

  Color color = Colors.black;
}
