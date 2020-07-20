import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmentor/main.dart';
import 'package:hmentor/track.dart';
class Mentor extends StatefulWidget {
  final DocumentSnapshot post;
  Mentor({this.post});
  @override
  _mentorState createState() => _mentorState();
}
class _mentorState extends State<Mentor> {
  String title = "Ask to HMentor";
  String getValue(){
     if(widget.post == null)
       {
         return null;
       }
     else {
       return widget.post.data["Problem Statement"];
     }}
     final _form = GlobalKey<FormState>();
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  final _emailFocusNode = FocusNode();
  final _problemStatementNode = FocusNode();
  final _problemDescriptionNode = FocusNode();
  final _nameNode = FocusNode();
  final _mobileNode = FocusNode();
  var _query = UserQuery(name: '', email: '', Mobile: "", problem_statement: "",help_description: "");

  @override
  void dispose(){
    _emailFocusNode.dispose();
    _problemDescriptionNode.dispose();
    _problemStatementNode.dispose();
    _nameNode.dispose();
    _mobileNode.dispose();
    super.dispose();
    getValue();
  }
  Future<void> uploadingData(String name, String email,
      String Mobile, String problem_statement, String help_description) async {
    await Firestore.instance.collection("User").document(_query.email).collection(title).add({
      'Problem Statement': problem_statement,
      'email': email,
      'Description': help_description,
      'Phone Number': Mobile,
      'Name' : name,
      'Reply' : "Waiting for Reply",
    });
  }
  void _saveForm() {
    // isValid variable is used to store the current status of form
    // _form.currentState.Validate() return the boolean value.
    final isValid = _form.currentState.validate();
    print(isValid);
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    uploadingData(_query.name,_query.email,_query.Mobile,_query.problem_statement,_query.help_description);
    showAlertDialog(context);
    print(_query.name);
    print(_query.email);
    print(_query.Mobile);
    print(_query.problem_statement);
    print(_query.help_description);
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("Close"),
      onPressed: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );}
    );
    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Text("Query Submitted..!"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Icon(Icons.check_circle,color: Colors.green,size: 60,),
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Text("We will get back to you within 12 Hours"),
        ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Text("Your Name:- "+_query.name,textAlign: TextAlign.left,),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Text("Email:- "+_query.email),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Text("Mobile:- "+_query.Mobile),
          ),

          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text("Statement:- "+_query.problem_statement),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text("Your Query:- "+_query.help_description),
          )
      ],),

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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.deepOrange[500],size: 30,), onPressed: null)
        ],
        backgroundColor: Colors.deepOrange[500],
        title: Padding(
          padding: const EdgeInsets.only(/*left: 70*/),
          child: Text(title,
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
                      padding: const EdgeInsets.only(top:20),
                      child: Text("If You Have question, Just Ask Mentor.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
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
                            prefixIcon: Icon(
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        onSaved: (value) {
                          _query = UserQuery(
                            name: value,
                            email: _query.email,
                            Mobile: _query.Mobile,
                            problem_statement: _query.problem_statement,
                            help_description: _query.help_description
                          );
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                         focusNode: _emailFocusNode,
                        onSaved: (value) {
                          _query = UserQuery(
                              name: _query.name,
                              email: value,
                              Mobile: _query.Mobile,
                              problem_statement: _query.problem_statement,
                              help_description: _query.help_description
                          );
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
                            prefixIcon: Icon(
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        focusNode: _mobileNode,
                        onSaved: (value) {
                          _query = UserQuery(
                              name: _query.name,
                              email: _query.email,
                              Mobile: value,
                              problem_statement: _query.problem_statement,
                              help_description: _query.help_description
                          );
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_problemStatementNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length <10 || value.length>10) {
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
                        controller: TextEditingController(text: getValue()),
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
                            hintText: "Problem Statement",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(
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
                         focusNode: _problemStatementNode,
                        onSaved: (value) {
                          _query = UserQuery(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              problem_statement: value,
                              help_description: _query.help_description
                          );
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_problemDescriptionNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 7) {
                            return "Enter the complete Statement";
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
                            hintText: "Help Description",
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
                         focusNode: _problemDescriptionNode,
                        onSaved: (value) {
                          _query = UserQuery(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              problem_statement: _query.problem_statement,
                              help_description: value
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 15) {
                            return "Enter the Brief Problem Description";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                           onTap: _saveForm,
                          splashColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
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
                                        offset: Offset(1, 1))
                                  ]),
                              child: Padding(
                                   padding: const EdgeInsets.only(top:8.0),
                                   child: Text(
                                        'Ask HMentor',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),textAlign: TextAlign.center,
                                      ),
                                 ),
                               ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("OR",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        InkWell(
                          onTap: () =>  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => track(Ti: title))),
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
                      ],
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

class UserQuery{
  final String name;
  final String email;
  final String Mobile;
  final String help_description;
  final String problem_statement;


  UserQuery({
    this.name,
    this.email,
    this.Mobile,
    this.problem_statement,
    this.help_description,
  });
}
