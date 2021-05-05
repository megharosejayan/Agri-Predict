import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agri_predict/models_provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:agri_predict/components/animator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:http/http.dart' as http;
import 'about.dart';

import 'dart:io';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var subscription;
  var connectionStatus;
  String _selectedcrop;
  String _selectedState;
  String _selectedSeason;
  List<String> districts = ['Please Choose the District', 'District'];
  String _selectedDistrict = 'Please Choose the District';

  final area = TextEditingController();
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  Widget copyright = Container(
    padding: const EdgeInsets.only(top: 15, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ),
  );
  // function to toggle circle animation
  // changeThemeMode(bool theme) {
  //   if (!theme) {
  //     _animationController.forward(from: 0.0);
  //   } else {
  //     _animationController.reverse(from: 1.0);
  //   }
  // }

  setDistrict() {
    if (_selectedState == "Kerala") {
      districts = [
        'Alappuzha',
        'Ernakulam',
        'Idukki',
        'Kannur',
        'Kasaragod',
        'Kollam',
        'Kottayam',
        'Kozhikode',
        'Malappuram',
        'Palakkad',
        'Pathanamthitta',
        'Thiruvananthapuram',
        'Thrissur',
        'Wayanad'
      ];
      _selectedDistrict = 'Alappuzha';
    } else if (_selectedState == "Andaman and Nicobar Islands") {
      districts = ['Nicobars', 'North And Middle Andaman', 'South Andamans'];
      _selectedDistrict = 'Nicobars';
    } else if (_selectedState == "Andhra Pradesh") {
      districts = [
        'Anantapur',
        'Chittoor',
        'East Godavari',
        'Guntur',
        'Kadapa',
        'Krishna',
        'Kurnool',
        'Prakasam',
        'Spsr Nellore',
        'Srikakulam',
        'Visakhapatanam',
        'Vizianagaram',
        'West Godavari'
      ];
      _selectedDistrict = 'Anantapur';
    } else if (_selectedState == "Karnataka") {
      districts = [
        'Bagalkot',
        'Bangalore Rural',
        'Belgaum',
        'Bellary',
        'Bengaluru Urban',
        'Bidar',
        'Bijapur',
        'Chamarajanagar',
        'Chikballapur',
        'Chikmagalur',
        'Chitradurga',
        'Dakshin Kannad',
        'Davangere',
        'Dharwad',
        'Gadag',
        'Gulbarga',
        'Hassan',
        'Haveri',
        'Kodagu',
        'Kolar',
        'Koppal',
        'Mandya',
        'Mysore',
        'Raichur',
        'Ramanagara',
        'Shimoga',
        'Tumkur',
        'Udupi',
        'Uttar Kannad',
        'Yadgir'
      ];
      _selectedDistrict = 'Bagalkot';
    } else if (_selectedState == "Bihar") {
      districts = [
        'Araria',
        'Arwal',
        'Aurangabad',
        'Banka',
        'Begusarai',
        'Bhagalpur',
        'Bhojpur',
        'Buxar',
        'Darbhanga',
        'Gaya',
        'Gopalganj',
        'Jamui',
        'Jehanabad',
        'Kaimur (Bhabua)',
        'Katihar',
        'Khagaria',
        'Kishanganj',
        'Lakhisarai',
        'Madhepura',
        'Madhubani',
        'Munger',
        'Muzaffarpur',
        'Nalanda',
        'Nawada',
        'Pashchim Champaran',
        'Patna',
        'Purbi Champaran',
        'Purnia',
        'Rohtas',
        'Saharsa',
        'Samastipur',
        'Saran',
        'Sheikhpura',
        'Sheohar',
        'Sitamarhi',
        'Siwan',
        'Supaul',
        'Vaishali'
      ];
      _selectedDistrict = 'Araria';
    } else if (_selectedState == "Madhya Pradesh") {
      districts = [
        'Agar Malwa',
        'Alirajpur',
        'Anuppur',
        'Ashoknagar',
        'Balaghat',
        'Barwani',
        'Betul',
        'Bhind',
        'Bhopal',
        'Burhanpur',
        'Chhatarpur',
        'Chhindwara',
        'Damoh',
        'Datia',
        'Dewas',
        'Dhar',
        'Dindori',
        'Guna',
        'Gwalior',
        'Harda',
        'Hoshangabad',
        'Indore',
        'Jabalpur',
        'Jhabua',
        'Katni',
        'Khandwa',
        'Khargone',
        'Mandla',
        'Mandsaur',
        'Morena',
        'Narsinghpur',
        'Neemuch',
        'Panna',
        'Raisen',
        'Rajgarh',
        'Ratlam',
        'Rewa',
        'Sagar',
        'Satna',
        'Sehore',
        'Seoni',
        'Shahdol',
        'Shajapur',
        'Sheopur',
        'Shivpuri',
        'Sidhi',
        'Singrauli',
        'Tikamgarh',
        'Ujjain',
        'Umaria',
        'Vidisha'
      ];
      _selectedDistrict = 'Alirajpur';
    } else if (_selectedState == "Maharashtra") {
      districts = [
        'Ahmednagar',
        'Akola',
        'Amravati',
        'Aurangabad',
        'Beed',
        'Bhandara',
        'Buldhana',
        'Chandrapur',
        'Dhule',
        'Gadchiroli',
        'Gondia',
        'Hingoli',
        'Jalgaon',
        'Jalna',
        'Kolhapur',
        'Latur',
        'Mumbai',
        'Nagpur',
        'Nanded',
        'Nandurbar',
        'Nashik',
        'Osmanabad',
        'Palghar',
        'Parbhani',
        'Pune',
        'Raigad',
        'Ratnagiri',
        'Sangli',
        'Satara',
        'Sindhudurg',
        'Solapur',
        'Thane',
        'Wardha'
      ];
      _selectedDistrict = 'Ahmednagar';
    } else if (_selectedState == "Assam") {
      districts = [
        'Baksa',
        'Barpeta',
        'Bongaigaon',
        'Cachar',
        'Chirang',
        'Darrang',
        'Dhemaji',
        'Dhubri',
        'Dibrugarh',
        'Dima Hasao',
        'Goalpara',
        'Golaghat',
        'Hailakandi',
        'Jorhat',
        'Kamrup',
        'Kamrup Metro',
        'Karbi Anglong',
        'Karimganj',
        'Kokrajhar',
        'Lakhimpur',
        'Marigaon',
        'Nagaon',
        'Nalbari',
        'Sivasagar',
        'Sonitpur',
        'Tinsukia',
        'Udalguri'
      ];
      _selectedDistrict = 'Baksa';
    } else if (_selectedState == "Chhattisgarh") {
      districts = [
        'Balod',
        'Baloda Bazar',
        'Balrampur',
        'Bastar',
        'Bemetara',
        'Bijapur',
        'Bilaspur',
        'Dantewada',
        'Dhamtari',
        'Durg',
        'Gariyaband',
        'Janjgir-Champa',
        'Jashpur',
        'Kabirdham',
        'Kanker',
        'Kondagaon',
        'Korba',
        'Korea',
        'Mahasamund',
        'Mungeli',
        'Narayanpur',
        'Raigarh',
        'Raipur',
        'Rajnandgaon',
        'Sukma',
        'Surajpur',
        'Surguja'
      ];
      _selectedDistrict = 'Balod';
    } else if (_selectedState == "Gujarat") {
      districts = [
        'Ahmadabad',
        'Amreli',
        'Anand',
        'Banas Kantha',
        'Bharuch',
        'Bhavnagar',
        'Dang',
        'Dohad',
        'Gandhinagar',
        'Jamnagar',
        'Junagadh',
        'Kachchh',
        'Kheda',
        'Mahesana',
        'Narmada',
        'Navsari',
        'Panch Mahals',
        'Patan',
        'Porbandar',
        'Rajkot',
        'Sabar Kantha',
        'Surat',
        'Surendranagar',
        'Tapi',
        'Vadodara',
        'Valsad'
      ];
      _selectedDistrict = 'Ahmadabad';
    } else if (_selectedState == "Haryana") {
      districts = [
        'Ambala',
        'Bhiwani',
        'Faridabad',
        'Fatehabad',
        'Gurgaon',
        'Hisar',
        'Jhajjar',
        'Jind',
        'Kaithal',
        'Karnal',
        'Kurukshetra',
        'Mahendragarh',
        'Mewat',
        'Palwal',
        'Panchkula',
        'Panipat',
        'Rewari',
        'Rohtak',
        'Sirsa',
        'Sonipat',
        'Yamunanagar'
      ];
      _selectedDistrict = 'Ambala';
    } else if (_selectedState == "Himachal Pradesh") {
      districts = [
        'Bilaspur',
        'Chamba',
        'Hamirpur',
        'Kangra',
        'Kinnaur',
        'Kullu',
        'Lahul And Spiti',
        'Mandi',
        'Shimla',
        'Sirmaur',
        'Solan',
        'Una'
      ];
      _selectedDistrict = 'Bilaspur';
    } else if (_selectedState == "Jammu and Kashmir") {
      districts = [
        'Anantnag',
        'Badgam',
        'Bandipora',
        'Baramulla',
        'Doda',
        'Ganderbal',
        'Jammu',
        'Kargil',
        'Kathua',
        'Kishtwar',
        'Kulgam',
        'Kupwara',
        'Leh Ladakh',
        'Poonch',
        'Pulwama',
        'Rajauri',
        'Ramban',
        'Reasi',
        'Samba',
        'Shopian',
        'Srinagar',
        'Udhampur'
      ];
      _selectedDistrict = 'Anantnag';
    } else if (_selectedState == "Arunachal Pradesh") {
      districts = [
        'Anjaw',
        'Changlang',
        'Dibang Valley',
        'East Kameng',
        'East Siang',
        'Kurung Kumey',
        'Lohit',
        'Longding',
        'Lower Dibang Valley',
        'Lower Subansiri',
        'Papum Pare',
        'Tawang',
        'Tirap',
        'Upper Siang',
        'Upper Subansiri',
        'West Kameng',
        'West Siang'
      ];
      _selectedDistrict = 'Anjaw';
    } else if (_selectedState == "Jharkhand") {
      districts = [
        'Bokaro',
        'Chatra',
        'Deoghar',
        'Dhanbad',
        'Dumka',
        'East Singhbum',
        'Garhwa',
        'Giridih',
        'Godda',
        'Gumla',
        'Hazaribagh',
        'Jamtara',
        'Khunti',
        'Koderma',
        'Latehar',
        'Lohardaga',
        'Pakur',
        'Palamu',
        'Ramgarh',
        'Ranchi',
        'Sahebganj',
        'Saraikela Kharsawan',
        'Simdega',
        'West Singhbhum'
      ];
      _selectedDistrict = 'Bokaro';
    } else if (_selectedState == "Dadra and Nagar Haveli") {
      districts = ['Dadra and Nagar Haveli'];
      _selectedDistrict = 'Dadra and Nagar Haveli';
    } else if (_selectedState == "Goa") {
      districts = ['North Goa', 'South Goa'];
      _selectedDistrict = 'North Goa';
    } else if (_selectedState == "Chandigarh") {
      districts = ['Chandigarh'];
      _selectedDistrict = 'Chandigarh';
    }
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    bool _load = false;

    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    Container textBuild(
      String text,
    ) {
      return Container(
        padding: const EdgeInsets.only(top: 0, bottom: 30),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: Colors.black),
          softWrap: true,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: DoubleBackToCloseApp(
        child: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height * 0.18,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/head.png')),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * .03,
                    left: size.height * .05,
                    right: size.height * .05,
                    bottom: size.height * .005),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/agri.jpeg'),
                          ),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                'AGRI PREDICT',
                                style: TextStyle(
                                    fontFamily: "Montserrat Medium",
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              Text(
                                'Plan Your Farming Ahead ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Montserrat Regular",
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.60,
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: size.width * 0.005,
                        right: size.width * 0.005,
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
                            top: size.height * 0.03,
                            bottom: size.height * 0.01),
                        child: Text(
                          "AGRI PREDICT - PREDICT YOUR CROP YIELD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )),
                  ),
                  textBuild(
                      "Agrict Predict is an App used to predict your crop yield in advance.  "
                      "\nAll you have to do is select : \nthe type of crop ypu plan to farm,"
                      "the state and district you are planning to farm in, \nthe area in acres, year and finally the season. \n\n"
                      "Happy Farming :)\n\n"),
                  Text(
                    "SELECT CROP ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 0, top: 1),
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      color: Color.fromARGB(150, 252, 244, 3),
                      child: DropdownButton<String>(
                        value: _selectedcrop,

                        //elevation: 5,
                        style: TextStyle(color: Colors.black),

                        items: <String>[
                          'Other Kharif pulses',
                          'Rice',
                          'Dry chillies',
                          'Maize',
                          'Moong(Green Gram)',
                          'Urad',
                          'Arhar/Tur',
                          'Groundnut',
                          'Sunflower',
                          'Bajra',
                          'Castor seed',
                          'Cotton(lint)',
                          'Horse-gram',
                          'Jowar',
                          'Ragi',
                          'Gram',
                          'Wheat',
                          'Masoor',
                          'Sesamum',
                          'Linseed',
                          'Safflower',
                          'Onion',
                          'Small millets',
                          'Other  Rabi pulses',
                          'Soyabean',
                          'Mesta',
                          'Rapeseed &Mustard',
                          'Niger seed',
                          'Peas & beans (Pulses)',
                          'Barley',
                          'Khesari'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Please choose the crop",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _selectedcrop = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Text(
                    "SELECT STATE ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 0, top: 1),
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      color: Color.fromARGB(150, 252, 244, 3),
                      child: DropdownButton<String>(
                        value: _selectedState,

                        //elevation: 5,
                        style: TextStyle(color: Colors.black),

                        items: <String>[
                          'Karnataka',
                          'Bihar',
                          'Madhya Pradesh',
                          'Maharashtra',
                          'Assam',
                          'Chhattisgarh',
                          'Andhra Pradesh',
                          'Gujarat',
                          'Haryana',
                          'Himachal Pradesh',
                          'Jammu and Kashmir',
                          'Arunachal Pradesh',
                          'Jharkhand',
                          'Kerala',
                          'Dadra and Nagar Haveli',
                          'Goa',
                          'Chandigarh',
                          'Andaman and Nicobar Islands',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Please choose the State",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _selectedState = value;
                          });
                          setDistrict();
                        },
                      ),
                    ),
                  ),
                  Text(
                    "SELECT DISTRCIT ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 0, top: 1),
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      color: Color.fromARGB(150, 252, 244, 3),
                      child: DropdownButton(
                        hint: Text("Please choose the District"),
                        value: _selectedDistrict,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDistrict = newValue;
                          });
                        },
                        items: districts.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Text(
                    "ENTER THE AREA ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Container(
                      width: 300,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the Area in hectares',
                          hintText: 'Enter Area Here in hectares',
                        ),
                        autofocus: false,
                        controller: area,
                      )),
                  Text(
                    "ENTER THE YEAR ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Container(
                      width: 300,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the Year',
                          hintText: 'Enter Year',
                        ),
                        autofocus: false,
                        //controller: area,
                      )),
                  Text(
                    "SELECT SEASON ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Center(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeason = "Autumn";
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/images/autumn.jpeg')),
                                SizedBox(height: 8),
                                Text(
                                  'Autumn',
                                  style: cardTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeason = "Winter";
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/images/winter.jpeg')),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Winter',
                                  style: cardTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeason = "Summer";
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/images/summer.jpeg')),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Summer',
                                  style: cardTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeason = "Rabi";
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image:
                                        AssetImage('assets/images/rabi.jpeg')),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Rabi',
                                  style: cardTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeason = "Kharif";
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/images/kharif.jpeg')),
                                SizedBox(height: 8),
                                Text(
                                  'Kharif',
                                  style: cardTextStyle,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
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
                      onPressed: () async {
                        setState(() {
                          _load = true;
                        });
                        print(_selectedState);
                        print(_selectedDistrict);
                        print(_selectedcrop);
                        print(_selectedSeason);
                        print(area.text);

                        try {
                          final response = await http.post(
                            Uri.parse("http://192.168.18.24:5000/API/postData"),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, dynamic>{
                              'state': _selectedState,
                              'city': _selectedDistrict,
                              'crop': _selectedcrop,
                              'season': _selectedSeason,
                              'area': area.text,
                            }),
                          );
                          print(response);
                          if (response.statusCode == 200) {
                            setState(() {
                              _load = false;
                            });
                            final json = jsonDecode(response.body) as Map;
                            if (json["status"] == "success") {
                              final data = json["data"] as double;
                              print(data);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AboutScreen(data: data)));
                            }
                          } else {
                            setState(() {
                              _load = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Server Error",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } catch (e) {
                          setState(() {
                            _load = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Server Error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: _load
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                              'SUBMIT',
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
        snackBar: const SnackBar(
          content: Text(
            'Press again to exit',
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  //external links to form, developer contact etc.

}
