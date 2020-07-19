import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:hmentor/main.dart';
import 'Constant.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed("/HomeScreen");
  }

  @override
  void initState() {
    super.initState();
    startTime();

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80.0),
        margin: EdgeInsets.only(bottom: 20.0),
        child: new Center(
          child: FadeAnimation(1.3,Column(
            children: <Widget>[
              new Container(
                child: Center(
                  child:FadeAnimation(1.3 ,Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset('assets/logo.jpg',
                          height: MediaQuery.of(context).size.height/2,
                          //width: MediaQuery.of(context).size.width/1.5,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Text("HMentor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.deepOrange[800]),),
              Text("Everything About Projects", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepOrange[900]),),
              SizedBox(height: 15.0,),
              SpinKitFoldingCube(color: Colors.orangeAccent, size: 30.0,)
            ],
          )),
        ),
      ),
    );
  }
}
