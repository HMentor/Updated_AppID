import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class trackReturn extends StatefulWidget {
  @override
  String email;
  String TI;
  trackReturn({this.email,this.TI});
  _trackReturnState createState() => _trackReturnState();

}



class _trackReturnState extends State<trackReturn> {


  int counter = 1;

//  navigateToDetail(DocumentSnapshot post) {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => DetailPage(
//              post: post,
//            )));
//  }

  // ignore: missing_return
  Future getPost0() async {
    var firestore = Firestore.instance;

    QuerySnapshot mixh =
    await firestore.collection("User").document(widget.email).collection("Ask to HMentor").getDocuments();
    return mixh.documents;
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
          child: Text(widget.email,
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

      body: SingleChildScrollView(
        child: Container(
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
                } else {
                  return ListView.builder(
//                      padding: const EdgeInsets.only(
//                          bottom: kFloatingActionButtonMargin + 200),
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
                              "$index. " + snapshot.data[index].data["Description"],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reply From HMentor:- " +
                                      snapshot.data[index].data["Reply"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38),
                                ),
//                              RaisedButton.icon(
//                                  onPressed: () =>
//                                      navigateToDetail(snapshot.data[index]),
//                                  label: Text("SeeMore"),
//                                  icon: Icon(Icons.arrow_right))
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}

