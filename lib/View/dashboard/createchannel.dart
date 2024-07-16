import 'package:flutter/material.dart';
import '../navigationbars/appbar.dart';
import '../navigationbars/bottombar.dart';
import '../navigationbars/drawer.dart';


class CreateChannel extends StatelessWidget {
  const CreateChannel({Key? key}) : super(key: key);

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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Channel Name:',
                  contentPadding: EdgeInsets.zero,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description:',
                  contentPadding: EdgeInsets.zero,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Host Name:',
                  contentPadding: EdgeInsets.zero,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Sub Topics:',
                  contentPadding: EdgeInsets.zero,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Implement channel creation logic here
                },
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
