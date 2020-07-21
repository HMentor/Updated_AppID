import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmentor/mentor.dart';

class trackReturn extends StatefulWidget {
  @override
  String email;
  String TI;
  trackReturn({this.email, this.TI});
  _trackReturnState createState() => _trackReturnState();
}

class _trackReturnState extends State<trackReturn> {
  List<DocumentSnapshot> _queries = [];
  int counter = 1;
  Future getPost0() async {
    var firestore = Firestore.instance;

    QuerySnapshot mixh = await firestore
        .collection("User")
        .document(widget.email)
        .collection("Ask to HMentor")
        .getDocuments();
    _queries = mixh.documents;
    return _queries;
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
            widget.email,
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
      // ignore: missing_return

      body:  Container(
          height: MediaQuery.of(context).size.height,
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
          child: FutureBuilder(
              future: getPost0(),
              // ignore: missing_return
              builder: (_, snapshot) {
                //proitem = snapshot.data["Problem Statement"];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    //height: MediaQuery.of(context).size.height,
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/LOAD.gif"),
                  );
                }
                if (_queries.length == 0) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error,size: 40,color: Colors.purple,),
                          Text("Opps...! SORRY",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),),
                          Text(
                            "No Queries. Need to post a query first from Ask to Hmentor Page",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(onTap: () =>  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mentor())),child: Text("Post Your First Query",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),))
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 20,
                            margin: EdgeInsets.all(10.8),
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                /*"Problem Statement:- " +"\n"+*/
                                "$index. " +
                                    snapshot.data[index].data["Description"],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                                    child: Divider(thickness: 3,color: Colors.green,),
                                  ),
                                  Text(
                                    "Reply From HMentor:- " +
                                        snapshot.data[index].data["Reply"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,fontSize: 17,),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });

                }
              }),
        ),

    );
  }
}
