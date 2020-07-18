import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange[400],
        title: Text(
          "Problem Statements",
          style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 29,
                  shadows: [
                    Shadow(
                        blurRadius: 6.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0))
                  ])),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10.8),
              elevation: 20,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Row(
                      children: [
                        CircleAvatar(backgroundImage: AssetImage('assets/logo.jpg'),maxRadius: 25,),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:15.0),
                              child: Text("HMentor",style: TextStyle(fontSize: 25),),
                            ),
                            Text("2020 HSpark"),
                          ],

                        )
                      ],

                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:25.0,left: 10),
                        child: Icon(Icons.error_outline,color: Colors.black,size: 30,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:25.0,top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Version",style: TextStyle(fontSize: 20),),
                            Text("1.0.0")
                          ],
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom:15.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:25.0,left: 10),
                          child: Icon(Icons.code,color: Colors.black,size: 30,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:25.0,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Size",style: TextStyle(fontSize: 20),),
                              Text("1.0.0")
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                ],
                
              ),
            ),
            Card(

              margin: EdgeInsets.all(10.8),
              elevation: 20,
              child: Column(
                children: [
                 Text("About App"),
                  Text("Our primary objective is to assist and guide students with well researched, categorised, and quality project topics with proper descriptionat free of cost. Most of the project topics are real-word problems took from various global events like Smart India Hackathon. Topics are well categories as per their complexity level and as per the type of development. Students can ask queries to the mentor from application. We are helping the student to solve his/her problem by providing virtual mentorship if student ask the query.We are not claiming any type of copyright. The data we have collected is from other websites and from portal. Hence the copyright is to the respective owner of data."),
                  ],

              ),

            ),
          ],
        ),
      ),
    );
  }
}
