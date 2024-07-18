import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/calling/callPage.dart';
import '../navigationbars/appbar.dart';
import '../navigationbars/bottombar.dart';
import '../navigationbars/drawer.dart';

class CreateChannel extends StatefulWidget {
  const CreateChannel({Key? key}) : super(key: key);

  @override
  State<CreateChannel> createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController channelNameController = TextEditingController();
  TextEditingController mainTopicNameController = TextEditingController();
  TextEditingController subTopicNameController = TextEditingController();
  TextEditingController hostNameController = TextEditingController();
  TextEditingController topicDescriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createChannel() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentReference docRef = _firestore.collection('channels').doc();
        String docId = docRef.id;

        await docRef.set({
          'id': docId,
          'channelName': channelNameController.text,
          'mainTopicName': mainTopicNameController.text,
          'subTopicName': subTopicNameController.text,
          'hostName': hostNameController.text,
          'topicDescription': topicDescriptionController.text,
          'createdAt': FieldValue.serverTimestamp(),
          'createdBy': user.uid,
        });

        // Navigate to CallPage or show success message
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallPage(
              callID: channelNameController
                  .text, // provide appropriate callID if needed
              userID: user.uid, // provide appropriate userID if needed
              userName: hostNameController.text,
            ),
          ),
        );
      } catch (e) {
        print('Error creating channel: $e');
        // Handle error, show a message to the user
      }
    } else {
      // Handle case where user is not authenticated
      print('User is not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: channelNameController,
                decoration: InputDecoration(hintText: "Channel Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: mainTopicNameController,
                decoration: InputDecoration(hintText: "Main Topic Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: subTopicNameController,
                decoration: InputDecoration(hintText: "Sub Topic Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: hostNameController,
                decoration: InputDecoration(hintText: "Host Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: topicDescriptionController,
                decoration: InputDecoration(hintText: "Topic Description"),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: createChannel,
                child: Text(
                  'Create Channel',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
