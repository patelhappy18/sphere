import 'package:flutter/material.dart';
import '../navigationbars/appbar.dart';
import '../navigationbars/bottombar.dart';
import '../navigationbars/drawer.dart';

class JoinChannelScreen extends StatelessWidget {
  const JoinChannelScreen({Key? key}) : super(key: key);

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
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Trending Channels',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        channelName = 'Kids';
                        break;
                      case 1:
                        channelName = 'Sports';
                        break;
                      case 2:
                        channelName = 'Food';
                        break;
                      case 3:
                        channelName = 'Games';
                        break;
                      case 4:
                        channelName = 'Travel';
                        break;
                      case 5:
                        channelName = 'Video';
                        break;
                      case 6:
                        channelName = 'Photography';
                        break;
                      case 7:
                        channelName = 'World';
                        break;
                      case 8:
                        channelName = 'Technology';
                        break;
                      case 9:
                        channelName = 'College';
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}