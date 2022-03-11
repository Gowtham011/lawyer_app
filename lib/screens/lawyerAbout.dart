import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LawyerAbout extends StatelessWidget {
  late final String lawEmail;
  late final String lawName;

  LawyerAbout({required this.lawEmail, required this.lawName});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lawyer's Information"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('lawAbout')
                  .document(lawEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                var lawAbout = snapshot.data;
                return Container(
                  padding: EdgeInsets.all(width * 0.015),
                  width: width,
                  height: height * 0.7,
                  margin: EdgeInsets.only(
                      left: width * 0.05,
                      top: height * 0.05,
                      right: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lawName,
                        style: TextStyle(
                            fontSize: height * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.stars,
                            size: height * 0.03,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            //lawAbout['spec'],
                            'spec',
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone,
                              size: height * 0.03, color: Colors.blue),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            //lawAbout['phone'],
                            'phone',
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email,
                              size: height * 0.03, color: Colors.green),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            lawEmail,
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About: ',
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38)),
                            padding: EdgeInsets.all(5),
                            height: height * 0.3,
                            width: width,
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  //lawAbout['about'],
                                  'about',
                                  style: GoogleFonts.abel(
                                      fontSize: height * 0.025),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
