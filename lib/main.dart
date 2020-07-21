import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:hmentor/About.dart';
import 'package:hmentor/List/ListPage.dart';
import 'package:hmentor/List/ListPage2.dart';
import 'package:hmentor/List/ListPage3.dart';
import 'package:hmentor/List/ListPage4.dart';
import 'package:hmentor/List/ListPage5.dart';
import 'package:hmentor/List/ListPage6.dart';
import 'package:hmentor/List/ListPage7.dart';
import 'package:hmentor/List/ListPage8.dart';
import 'package:hmentor/List/ListPage9.dart';
import 'package:hmentor/SplashScreen.dart';
import 'package:hmentor/banner.dart';
import 'package:hmentor/mentor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new SplashScreen(), routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new MyHomePage(),
    },
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  TabController _tabController;
  int _counter= 0;
  @override
  void initState() {
    _tabController = new TabController(length: 9, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double sizee = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top:10,left: 10),
          child: CircleAvatar(backgroundImage: AssetImage('assets/logo.jpg'),maxRadius: 10,),
        ),
        backgroundColor: Colors.deepOrange[400],
        title: Padding(
          padding: const EdgeInsets.only(/*left: 60*/),
          child: Text(
            "Problem Statements",
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: sizee/14,
                    shadows: [
                  Shadow(
                      blurRadius: 6.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0))
                ])),
          ),
        ),
//
        actions: [
          IconButton(icon: Icon(Icons.error_outline,color: Colors.white,size: 30,), onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => About())))
        ],
        bottom: TabBar(
          onTap: (int index){ setState(() {
            _counter = index;});},
          isScrollable: true,
         // isScrollable: true,
          labelPadding: EdgeInsets.only(top: 12, right: 30, left: 50),
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          tabs: [
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 28,
                  ),
                  Text(
                    "Mobile Dev Simple",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.phone_iphone,
                    size: 28,
                  ),
                  Text(
                    "Mobile Dev Medium",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )],),),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.phonelink_setup,
                    size: 28,
                  ),
                  Text(
                    "Mobile Dev Hard",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.laptop_chromebook,
                    size: 28,
                  ),
                  Text(
                    "Web Dev Simple",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.laptop_mac,
                    size: 28,
                  ),
                  Text(
                    "Web Dev Medium",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.laptop_windows,
                    size: 28,
                  ),
                  Text(
                    "Web Dev Hard",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.crop_rotate,
                    size: 28,
                  ),
                  Text(
                    "Miscellaneous Simple",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.phonelink_off,
                    size: 28,
                  ),
                  Text(
                    "Miscellaneous Medium",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
            new Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.devices_other,
                    size: 28,
                  ),
                  Text(
                    "Miscellaneous Hard",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body:
      TabBarView(
           // physics: PageScrollPhysics(),
           // physics: NeverScrollableScrollPhysics(),
            children: [

              SingleChildScrollView(

                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListPage(),
                    ),
                    BannerAdPage()
                  ],
                ),
              ),
                  SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage2(),
                      ),
                    ),
                     SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage3(),
                      ),
                    ),
                     SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.start,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage4(),
                      ),
                    ),
                   SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.start,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage5(),
                      ),
                    ),
                  SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage6(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage7(),
                      ),
                    ),
                      SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage8(),
                      ),
                    ),

                 SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListPage9(),
                      ),
                    ),
            ],
            controller: _tabController,
          ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(),
        child: Draggable(
          feedback: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Mentor())),
            child: Icon(Icons.face),
            backgroundColor: Colors.green,
          ),
          child: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Mentor())),
            child: Icon(Icons.face),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
