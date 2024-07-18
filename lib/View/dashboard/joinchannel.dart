import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/calling/callPage.dart';
import '../navigationbars/appbar.dart';
import '../navigationbars/bottombar.dart';
import '../navigationbars/drawer.dart';

class JoinChannelScreen extends StatefulWidget {
  const JoinChannelScreen({Key? key}) : super(key: key);

  @override
  State<JoinChannelScreen> createState() => _JoinChannelScreenState();
}

class _JoinChannelScreenState extends State<JoinChannelScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> channels = [];

  String? _phoneNumber; // Variable to hold the logged-in user's phone number
  String userName = ''; // Variable to hold the logged-in user's phone number
  String userId = '';
  @override
  void initState() {
    super.initState();
    fetchChannels();
    _fetchPhoneNumber(); // Fetch phone number when screen initializes
    fetchFirstNameByPhoneNumber(_phoneNumber);
  }

  void _fetchPhoneNumber() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _phoneNumber = user.phoneNumber;
      });
    }
  }

  Future<String?> fetchFirstNameByPhoneNumber(String? phoneNumber) async {
    try {
      // Query the 'users' collection to find the document where 'phoneNumber' matches
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      // Check if there's exactly one document (since phone number should be unique)
      if (querySnapshot.docs.length == 1) {
        var userDoc = querySnapshot.docs.first;
        // Retrieve and return the 'firstName'
        userName = userDoc.data()['firstName'];
        userId = userDoc.data()['phoneNumber'];
      } else {
        // Handle the case where no document or multiple documents match the phone number
        print('No user found with phoneNumber $phoneNumber');
        return null;
      }
    } catch (e) {
      print('Error fetching first name: $e');
      return null;
    } catch (e) {
      print('Error fetching first name: $e');
      return null;
    }
  }

  Future<void> fetchChannels() async {
    QuerySnapshot querySnapshot = await _firestore.collection('channels').get();
    setState(() {
      channels = querySnapshot.docs;
    });
  }

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
                image: AssetImage(
                    'assets/images/background.jpg'), // Path to your background image
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
                channels.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: channels.map((channel) {
                          return InkWell(
                            onTap: () {
                              // Handle channel join
                              joinChannel(channel.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
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
                                  channel['channelName'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  void joinChannel(String channelId) {
    print(channelId + "asdasdasdsdasdasdsadasdsad");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          callID: channelId, // provide appropriate callID if needed
          userID: userId, // provide appropriate userID if needed
          userName: userName,
        ),
      ),
    );
    // Navigate to a new screen or perform the necessary actions to join the channel
  }
}
