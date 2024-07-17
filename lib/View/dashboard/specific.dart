import 'package:flutter/material.dart';
import '../navigationbars/appbar.dart';
import '../navigationbars/bottombar.dart';
import '../navigationbars/drawer.dart';


class SpecificChannelScreen extends StatelessWidget {
  const SpecificChannelScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: CustomAppBar(),
  drawer: CustomDrawer(),
  backgroundColor: Colors.white,
  body: Stack(
  children: [
  // Background image
  Container(
  decoration: BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/images/background.jpg'), // Path to your background image
  fit: BoxFit.cover,
  ),
  ),
  ),
  Column(
  children: [
  Expanded(
  child: SingleChildScrollView(
  padding: EdgeInsets.all(16.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Padding(
  padding: const EdgeInsets.symmetric(vertical: 12.0),
  child: Text(
  'Kids Channel',
  style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  ),
  ),
  ),
  Text(
  'Welcome to the Kids channel! This channel is dedicated to fun and educational content for kids of all ages.',
  style: TextStyle(
  fontSize: 15,
  color: Colors.black,
  ),
  ),
  GridView.count(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  children: List.generate(10, (index) {
  String channelName;
  switch (index) {
  case 0:
  channelName = 'Kids Videos';
  break;
  case 1:
  channelName = 'Kids Games';
  break;
  case 2:
  channelName = 'Learning Activities';
  break;
  case 3:
  channelName = 'Story Time';
  break;
  case 4:
  channelName = 'Art and Crafts';
  break;
  case 5:
  channelName = 'Educational Shows';
  break;
  case 6:
  channelName = 'Children\'s Songs';
  break;
  case 7:
  channelName = 'Science Experiments';
  break;
  case 8:
  channelName = 'Math Challenges';
  break;
  case 9:
  channelName = 'Animal Adventures';
  break;
  default:
  channelName = 'All';
  }

  return InkWell(
  onTap: () {
  // Handle button tap
  },
  child: Container(
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(50),
  boxShadow: [
  BoxShadow(
  color: Colors.grey.withOpacity(0.3),
  spreadRadius: 2,
  blurRadius: 5,
  offset: Offset(0, 3),
  ),
  ],
  ),
  child: Center(
  child: Text(
  channelName,
  style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  ),
  );
  }),
  ),
  ],
  ),
  ),
  ),
  ],
  ),
  ],
  ),
  bottomNavigationBar: CustomBottomNavigationBar(),
  );
  }
  }
