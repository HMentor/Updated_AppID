import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmentor/main.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  final _form = GlobalKey<FormState>();
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  final _emailFocusNode = FocusNode();
  final _subject = FocusNode();
  final _feedback_suggestion = FocusNode();
  final _nameNode = FocusNode();
  final _mobileNode = FocusNode();
  var _query = feedbackUser(
      name: '', email: '', Mobile: "", subject: "", feedback_suggestion: "");
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _subject.dispose();
    _feedback_suggestion.dispose();
    _nameNode.dispose();
    _mobileNode.dispose();
    super.dispose();
    //getValue();
  }

  Future<void> uploadingData(String name, String email, String Mobile,
      String subject, String feedback_suggestion) async {
    await Firestore.instance
        .collection("User")
        .document(_query.email)
        .collection("Feedback&Suggestion")
        .add({
      'Problem Statement': subject,
      'Email': email,
      'Description': feedback_suggestion,
      'Phone Number': Mobile,
      'Name': name,
    });
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    print(isValid);
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    uploadingData(_query.name, _query.email, _query.Mobile, _query.subject,
        _query.feedback_suggestion);
    showAlertDialog(context);
    print(_query.name);
    print(_query.email);
    print(_query.Mobile);
    print(_query.subject);
    print(_query.feedback_suggestion);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
        child: Text("Close"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        });
    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: const Text("Feedback Submitted..!"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child:const Text(
                "Thank you for your valuable time. We will get back to you within 12 Hours if needed"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Your Name:- " + _query.name,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("Email:- " + _query.email),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text("Mobile:- " + _query.Mobile),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Subject:- " + _query.subject),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("Feedback/Suggestion:- " + _query.feedback_suggestion),
          )
        ],
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sizee = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.deepOrange[500],
                size: 30,
              ),
              onPressed: null)
        ],
        backgroundColor: Colors.deepOrange[500],
        title: Padding(
          padding: const EdgeInsets.only(/*left: 70*/),
          child: Text(
            "Feedback & Suggestion",
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: sizee/16,
                    shadows: [
                  Shadow(
                      blurRadius: 6.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0))
                ])),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.deepOrange[300],
                      Colors.deepOrange[300],
                      Colors.deepOrange[300],
                      Colors.deepOrange[400],
                    ],
                  ),
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(185),
                    bottomRight: Radius.circular(185),
                  )),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "Please give your feedback or suggestions related to the Application.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 20, top: 20),
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
                            hintText: "Full Name",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            prefixIcon: const Icon(
                              Icons.person_pin,
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
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: value,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 5) {
                            return "Enter the correct name";
                          }
                          return null;
                        },
                      ),
                    ),
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
                            prefixIcon: const Icon(
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        focusNode: _emailFocusNode,
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: value,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_mobileNode);
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
                            hintText: "Contact Number",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            prefixIcon: const Icon(
                              Icons.phone_iphone,
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
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        focusNode: _mobileNode,
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: value,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_subject);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 10 || value.length > 10) {
                            return "Enter the Valid Mobile Number.";
                          }
                          return null;
                        },
                      ),
                    ),
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
                            hintText: "Subject",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            prefixIcon: const Icon(
                              Icons.sync_problem,
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
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        focusNode: _subject,
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: value,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_feedback_suggestion);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 5) {
                            return "Enter the complete subject";
                          }
//                          }
                          return null;
                        },
                      ),
                    ),
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
                            hintText: "Feedback/Suggestion",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
                              Icons.view_list,
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
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        focusNode: _feedback_suggestion,
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: value);
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 7) {
                            return "Enter the Brief Suggestion";
                          }
                          return null;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: _saveForm,
                      splashColor: Colors.grey,
                      child: Container(
                        width: sizee/1.5,
                        height: MediaQuery.of(context).size.height/17,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 25.0,
                                  spreadRadius: 5.0,
                                  color: Colors.yellow,
                                  offset: Offset(1, 1))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.send,
                                size: 40,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: const Text(
                                'Send It',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                           const Icon(
                              Icons.send,
                              size: 40,
                              color: Colors.deepOrangeAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class feedbackUser {
  final String name;
  final String email;
  final String Mobile;
  final String subject;
  final String feedback_suggestion;

  feedbackUser({
    this.name,
    this.email,
    this.Mobile,
    this.subject,
    this.feedback_suggestion,
  });
}
