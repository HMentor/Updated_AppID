import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DetaiPage.dart';
import 'mentor.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();

  final int icounter;
  const ListPage({Key key, this.icounter}) : super(key: key);
}

class _ListPageState extends State<ListPage> {
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }


  Future setPost() {
    if ( widget.icounter == 0) {
      return getPost0();
    }
    if ( widget.icounter == 1) {
      return getPost1();
    }
    if ( widget.icounter == 2){
      return getPost2();
    }
    if ( widget.icounter == 3){
      return getPost3();
    }
    if ( widget.icounter == 4)
      {
       return getPost4();
      }
    if ( widget.icounter == 5)
      {
        return getPost5();
      }
    if ( widget.icounter == 6){
      return getPost6();
    }
    if (widget.icounter == 7){
     return getPost7();
    }
    if (widget.icounter == 8){
      return getPost8();
    }
  }

  Future getPost0() async {
    var firestore = Firestore.instance;

      QuerySnapshot mixh =
          await firestore.collection("Mobile Based Simple").getDocuments();
      return mixh.documents;

  }

  Future getPost1() async {
    var firestore = Firestore.instance;
    // else{
    //if(widget.currentIndex ==2 && widget.icounter==0) {
    QuerySnapshot qn =
        await firestore.collection("Mobile Based Medium").getDocuments();
    return qn.documents;

  }

  // if(widget.currentIndex ==0 && widget.icounter==0){
  Future getPost2() async {
    var firestore = Firestore.instance;
    QuerySnapshot MBS =
        await firestore.collection("Mobile Based Hard").getDocuments();
    return MBS.documents;
  }

  //else if(widget.currentIndex ==1 && widget.icounter==0)

  Future getPost3() async {
    var firestore = Firestore.instance;
    QuerySnapshot mbm =
        await firestore.collection("Web Based Simple").getDocuments();
    return mbm.documents;
  }

  Future getPost4() async {
    var firestore = Firestore.instance;
    QuerySnapshot wbs =
        await firestore.collection("Web Based Medium").getDocuments();
    return wbs.documents;
  }

  Future getPost5() async{
    var firestore = Firestore.instance;
    QuerySnapshot wbh = await firestore.collection("Web Based Hard")
        .getDocuments();
    return wbh.documents;
  }
  Future getPost6() async{
    var firestore = Firestore.instance;
    QuerySnapshot ms = await firestore.collection("Misce Based Simple")
        .getDocuments();
    return ms.documents;
  }

  Future getPost7() async{
    var firestore = Firestore.instance;
    QuerySnapshot mm = await firestore.collection("Misce Based Medium")
        .getDocuments();
    return mm.documents;
  }

  Future getPost8() async{
    var firestore = Firestore.instance;
    QuerySnapshot wbm = await firestore.collection("Misce Based Hard")
        .getDocuments();
    return wbm.documents;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Mobile Hard"),),
      // ignore: missing_return

      body: FutureBuilder(

          future: setPost(),
          // ignore: missing_return
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                //height: MediaQuery.of(context).size.height,
                alignment: Alignment.topCenter,
                child: Image.asset("assets/LOAD.gif"),
              );
            } else {
              return ListView.builder(

                  padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin+120),
                shrinkWrap: true,

                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index)
                  {
                    return Card(
                      margin: EdgeInsets.all(15.8),
                      color: Colors.deepOrangeAccent,
                      child: ListTile(
                        title: Text(
                          "Problem Statement:- " +
                              snapshot.data[index].data["Problem Statement"],
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          "Required Skills:- " +
                              snapshot.data[index].data["Required Skill"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                         trailing: RaisedButton.icon(onPressed: () => navigateToDetail(snapshot.data[index]),
                         icon: Icon(Icons.arrow_right), label: Text("SeeMore")),

                      ),
                    );
                  });
            }
          }),
    );
  }
}
