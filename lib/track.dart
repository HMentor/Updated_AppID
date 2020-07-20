import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmentor/QueryTrack.dart';
import 'package:hmentor/banner.dart';

import 'DetaiPage.dart';

class track extends StatefulWidget {
  String Ti;
  track({this.Ti});
  @override
  _trackState createState() => _trackState();

}

TextEditingController editingController;

class _trackState extends State<track> {
  final _form = GlobalKey<FormState>();

var uemail = UEmail(email: "");
  int counter = 1;

  navigateToDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => trackReturn(email: uemail.email,TI: widget.Ti,)));
  }

  // ignore: missing_return
  Future getPost0() async {
    var firestore = Firestore.instance;

    QuerySnapshot mixh =
    await firestore.collection("Mobile Based Simple").getDocuments();
    return mixh.documents;
  }

void _saveForm() {
  // isValid variable is used to store the current status of form
  // _form.currentState.Validate() return the boolean value.
  final isValid = _form.currentState.validate();
  print(isValid);
  if (!isValid) {
    return;
  }
  //_form.currentState.save is void type expression.
  //_form.currentState.save helps to save the current state of form.
  _form.currentState.save();
  navigateToDetail();
}


    // set up the AlertDialog

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.deepOrange[500],size: 30,), onPressed: null)
        ],
        backgroundColor: Colors.deepOrange[500],
        title: Padding(
          padding: const EdgeInsets.only(/*left: 70*/),
          child: Text("Track your Query",
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                          blurRadius: 6.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0))
                    ])),
          ),
        ),
      ),
      // ignore: missing_return

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.6, 0.9],
            colors: [
              Colors.deepOrange[300],
              Colors.deepOrange[200],
              Colors.deepPurple[200],
              Colors.deepPurple[300],
            ],
          ),
        ),
         child: Form(
           key: _form,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Column(children: [
                   Padding(
                     padding: const EdgeInsets.only(
                         left: 30.0, right: 30.0, bottom: 20, top: 10),
                     child: TextFormField(
                       decoration: InputDecoration(
                           errorStyle: TextStyle(
                               color: Colors.yellow,
                               fontWeight: FontWeight.bold,
                               fontSize: 15),
                           errorBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                   color: Colors.yellow,
                                   style: BorderStyle.solid,
                                   width: 3),
                               borderRadius: BorderRadius.circular(20)),
                           hintText: "Email",
                           hintStyle: TextStyle(
                               fontSize: 20,
                               color: Colors.white,
                               fontWeight: FontWeight.bold),
                           prefixIcon: Icon(
                             Icons.email,
                             color: Colors.white,
                           ),
                           enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                   color: Colors.white,
                                   style: BorderStyle.solid,
                                   width: 3),
                               borderRadius: BorderRadius.circular(20))),
                       textInputAction: TextInputAction.next,
                       cursorColor: Colors.blue,
                       keyboardType: TextInputType.emailAddress,
                       style: TextStyle(
                         // white color to the input text
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 20),
                       onSaved: (value) {
                         uemail = UEmail(
                           email: value
                         );
                       },
                       onFieldSubmitted: (_) {

                       },
                       validator: (value) {
                         if (value.isEmpty) {
                           return "This field can not be Empty";
                         }
                         if (!EmailValidator.validate(value, true)) {
                           return "Enter the Valid Email.";
                         }
                         return null;
                       },
                     ),
                   ),
                   InkWell(
                     onTap: () => { _saveForm()},
                     splashColor: Colors.grey,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         width: 170,
                         height: 40,
                         margin: EdgeInsets.only(top: 20),
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(50),
                             boxShadow: [
                               BoxShadow(
                                   blurRadius: 25.0,
                                   spreadRadius: 5.0,
                                   color: Colors.yellow,
                                   //offset is used for distancing of shadow from text.
                                   //offset shadows goes into right bottom
                                   offset: Offset(1, 1))
                             ]
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(top:8.0),
                           child: Text(
                             'Track your Query',
                             style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.green),textAlign: TextAlign.center,
                           ),
                         ),

                       ),
                     ),
                   ),
                   BannerAdPage()
                 ],),
               ]),
         ),

      ),
    );
  }
}
class UEmail{
  final String email;
  UEmail({this.email});
}


