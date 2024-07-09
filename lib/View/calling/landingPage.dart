import 'package:flutter/material.dart';
import 'package:myvoiceapp/View/calling/callPage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController callIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(hintText: "Please enter username"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userIdController,
                decoration: InputDecoration(hintText: "Please enter userId"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: callIdController,
                decoration: InputDecoration(hintText: "Please enter room id"),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                          callID: callIdController.text,
                          userID: userIdController.text,
                          userName: userNameController.text),
                    ),
                  );
                },
                child: Text('Join the Call'))
          ],
        ),
      ),
    );
  }
}
