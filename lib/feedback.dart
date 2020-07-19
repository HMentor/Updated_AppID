import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmentor/main.dart';
import 'package:hmentor/sendMail.dart';


class feedback extends StatefulWidget {
//  final DocumentSnapshot post;
//  feedback({this.post});

  @override
  _feedbackState createState() => _feedbackState();
}

// ignore: camel_case_types
class _feedbackState extends State<feedback> {
//  TextEditingController tx
//  String getValue(){
//    if(widget.post == null)
//    {
//      return null;
//    }
//    else {
//      return widget.post.data["Problem Statement"];
//    }
//
//  }

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

  var _query =
      feedbackUser(name: '', email: '',Mobile: "", subject: "", feedback_suggestion: "");

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
    await Firestore.instance.collection("Feedback and Suggestion").add({
      'Problem Statement': subject,
      'Email': email,
      'Description': feedback_suggestion,
      'Phone Number': Mobile,
      'Name': name,
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
    //_form.currentState.save is void type expression.
    //_form.currentState.save helps to save the current state of form.
    _form.currentState.save();
    uploadingData(_query.name, _query.email, _query.Mobile, _query.subject,
        _query.feedback_suggestion);
    sendMail(email: _query.email,name: _query.name,subject: _query.subject,suggestion: _query.feedback_suggestion,mobile: _query.Mobile);
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

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Text("Feedback Submitted..!"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
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

    // show the dialog
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
                    fontSize: 25,
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
              //To Adjust with every device screen MediaQuery used
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              //decoration for circular radius of Container
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

              //Form is used to taking the user input in form manner

              child: Form(
                //global form key is used to control the behavior of form.
                //key is used as controller of form
                key: _form,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Please give your feedback or suggestions related to the Application.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,),textAlign: TextAlign.center,
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

                        //textInputAction property provides the buttons on the right bottom corners of KEYBOARD
                        //in this case next button will provided on keyboard
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,

                        //Style for the input text of textFormField
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        //Here focus node is assigned
                        //though this focusNode we can control email TextFormField
                        // focusNode: _emailFocusNode,

                        //When save button pressed form keyboard the value of text-field is assigned to the email
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: value,
//                            Default value i.e '' (null) is assigned to the password.
//                            every time when saving the value, assign the value to only variable related to the text-field and keep other value as default.
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
//                          //after pressing the enter button from keyboard, control will transfer to the next field
//                          // next field can be requested using requestFocus
//                          //_passFocus is focus node instance of password textformfield
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },

                        //validator function takes the current value from textformfield as a argument
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 5) {
                            return "Enter the correct name";
                          }

                          //EmailValidator is function of dart library that helps to validate the email id
//                          if (!EmailValidator.validate(value, true)) {
//                            return "Enter the Valid Email.";
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

                        //textInputAction property provides the buttons on the right bottom corners of KEYBOARD
                        //in this case next button will provided on keyboard
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.emailAddress,

                        //Style for the input text of textFormField
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        //Here focus node is assigned
                        //though this focusNode we can control email TextFormField
                        focusNode: _emailFocusNode,

                        //When save button pressed form keyboard the value of text-field is assigned to the email
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: value,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          //after pressing the enter button from keyboard, control will transfer to the next field
                          // next field can be requested using requestFocus
                          //_passFocus is focus node instance of password textformfield
                          FocusScope.of(context).requestFocus(_mobileNode);
                        },

                        //validator function takes the current value from textformfield as a argument
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }

                          // EmailValidator is function of dart library that helps to validate the email id
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

                        //textInputAction property provides the buttons on the right bottom corners of KEYBOARD
                        //in this case next button will provided on keyboard
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.phone,

                        //Style for the input text of textFormField
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        //Here focus node is assigned
                        //though this focusNode we can control email TextFormField
                        focusNode: _mobileNode,

                        //When save button pressed form keyboard the value of text-field is assigned to the email
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: value,
                              subject: _query.subject,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          //after pressing the enter button from keyboard, control will transfer to the next field
                          // next field can be requested using requestFocus
                          //_passFocus is focus node instance of password textformfield
                          FocusScope.of(context).requestFocus(_subject);
                        },

                        //validator function takes the current value from textformfield as a argument
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }

                          // EmailValidator is function of dart library that helps to validate the email id
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
                        //controller: TextEditingController(text: getValue()),
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

                        //textInputAction property provides the buttons on the right bottom corners of KEYBOARD
                        //in this case next button will provided on keyboard
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.multiline,

                        //Style for the input text of textFormField
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        //Here focus node is assigned
                        //though this focusNode we can control email TextFormField
                        focusNode: _subject,

                        //When save button pressed form keyboard the value of text-field is assigned to the email
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: value,
                              feedback_suggestion: _query.feedback_suggestion);
                        },
                        onFieldSubmitted: (_) {
                          //after pressing the enter button from keyboard, control will transfer to the next field
                          // next field can be requested using requestFocus
                          //_passFocus is focus node instance of password textformfield
                          FocusScope.of(context)
                              .requestFocus(_feedback_suggestion);
                        },

                        //validator function takes the current value from textformfield as a argument
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 5) {
                            return "Enter the complete subject";
                          }

                          //EmailValidator is function of dart library that helps to validate the email id
//                          if (!EmailValidator.validate(value, true)) {
//                            return "Enter the Valid Email.";
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

                        //textInputAction property provides the buttons on the right bottom corners of KEYBOARD
                        //in this case next button will provided on keyboard
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.multiline,

                        //Style for the input text of textFormField
                        style: TextStyle(
                            // white color to the input text
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        //Here focus node is assigned
                        //though this focusNode we can control email TextFormField
                        focusNode: _feedback_suggestion,

                        //When save button pressed form keyboard the value of text-field is assigned to the email
                        onSaved: (value) {
                          _query = feedbackUser(
                              name: _query.name,
                              email: _query.email,
                              Mobile: _query.Mobile,
                              subject: _query.subject,
                              feedback_suggestion: value);
                        },
                        onFieldSubmitted: (_) {
                          //after pressing the enter button from keyboard, control will transfer to the next field
                          // next field can be requested using requestFocus
                          //_passFocus is focus node instance of password textformfield
                          //FocusScope.of(context).requestFocus(_passFocusNode);
                          _saveForm();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },

                        //validator function takes the current value from textformfield as a argument
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field can not be Empty";
                          }
                          if (value.length < 7) {
                            return "Enter the Brief Suggestion";
                          }

                          //EmailValidator is function of dart library that helps to validate the email id
//                          if (!EmailValidator.validate(value, true)) {
//                            return "Enter the Valid Email.";
//                          }
                          return null;
                        },
                      ),
                    ),

                    //here InkWell is used for splashColors
                    InkWell(
                      onTap: _saveForm,
                      splashColor: Colors.grey,
                      child: Container(
                        width: 300,
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
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.face,
                                size: 40,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                'Send It',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                            Icon(
                              Icons.face,
                              size: 40,
                              color: Colors.deepOrangeAccent,
                            )
                          ],
                        ),
                      ),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 10.0),
//                      child: Text("Forget Password ?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white,),),
//                    ),
//                    //Expanded property is used here for preventing the exception of renderFlex
//                    //****************Exception will Be like Below****************
//                    //The overflowing RenderFlex has an orientation of Axis.horizontal.
//                    //The edge of the RenderFlex that is overflowing has been marked in the rendering
//                    // with a yellow and black striped pattern. This is usually caused by the contents being too big for the RenderFlex.
//                    //Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit
//                    // within the available space instead of being sized to their natural size.
//                    //This is considered an error condition because it indicates that there is content that cannot be seen.
//                    // If the content is legitimately bigger than the available space, consider clipping it with a ClipRect widget
//                    // before putting it in the flex, or using a scrollable container rather than a Flex, like a ListView.
//                    // Expanded(
//                    // child:
//                    Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.only(top: 40.0),
//                                child: Text(
//                                  "Don't Have Account?",
//                                  style: TextStyle(
//                                      color: Colors.white, fontSize: 20),
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(top: 40.0),
//                                child: InkWell(
////                                  onTap: () => Navigator.push(
////                                      context, new MaterialPageRoute(
////                                      builder: (context) => new RegistrationRoleSelection())),
//                                  splashColor: Colors.cyanAccent,
//                                  child: Text(
//                                    " SIGN UP NOW",
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 20,
//                                        fontWeight: FontWeight.bold,
//                                        shadows: [
//                                          Shadow(
//                                              blurRadius: 6.0,
//                                              color: Colors.black,
//                                              offset: Offset(5.0, 5.0))
//                                        ]),
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: Text('For Role',style: TextStyle(
//                                color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
//                          ),
//                          GestureDetector(
//                            onTap: () {
////                             if(_currentIndex == 0){
////                                Navigator.push(
////                                    context, new MaterialPageRoute(
////                                    builder: (context) => new MyLoginApp()));
////                              }
//                            },
//                            child: Container(
//                              width: MediaQuery.of(context).size.width/1.4,
//                              height: 40,
//                              margin: EdgeInsets.only(top: 20,bottom: 20),
//                              decoration: BoxDecoration(
//
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(50),
//                                  boxShadow: [
//                                    BoxShadow(
//                                        blurRadius: 25.0,
//                                        spreadRadius: 5.0,
//                                        color: Colors.yellow,
//
//                                        //offset is used for distancing of shadow from text.
//                                        //offset shadows goes into right bottom
//                                        offset: Offset(1, 1))
//                                  ]),
////                              child: Text(
////
////                                _options[_currentIndex],
////                                style: TextStyle(
////                                  color: Colors.deepOrangeAccent,
////                                  fontSize: 35,
////                                  fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
////                              ),
//                            ),
//                          ),
//                          Text(
//                            "Choose Your Role From Below",
//                            style: TextStyle(
//                              fontSize: 20,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white,),
//                          ),
//                          Icon(Icons.arrow_downward,color: Colors.white,size: 20,)
//                        ]),
//                    //),
                  ],
                ),
              ),
            ),
            //Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height / 2,

            //decoration for circular radius of Container
            //  decoration: BoxDecoration(
            //     color: Colors.pinkAccent,
            //    borderRadius: BorderRadius.only(
            //      topLeft: Radius.circular(-10),
            //     topRight: Radius.circular(-10),
            //   )),

            //  )
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
