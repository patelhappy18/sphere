import 'package:flutter/material.dart';

class MessagingScreen extends StatelessWidget {
  final List<Message> messages = []; // Initialize with an empty list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add logic here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: messages[index].avatarColor,
                    child: Text(
                      messages[index].sender[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(messages[index].sender),
                  subtitle: Text(messages[index].text),
                  trailing: Text(messages[index].time),
                  onTap: () {
                    // Add navigation logic here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time;
  final Color avatarColor;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.avatarColor,
  });
}
