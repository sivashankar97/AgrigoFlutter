import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signinexample/UserScreen/plants/datentime.dart';
import 'package:signinexample/UserScreen/plants/productDetails.dart';
import 'package:signinexample/UserScreen/plants/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HyApp extends StatefulWidget {
  String collname;

  HyApp({this.collname});


  String currentDay(BuildContext context) {
    return DateTimeUtils.currentDay;
  }

  @override
  _HyAppState createState() => _HyAppState();
}

class _HyAppState extends State<HyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[700],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 0.0, left: 56.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ShadowImage(),
                  Container(
                    // margin: EdgeInsets.only(top: 22.0),
                    child: Text(
                      '${widget.currentDay(context)}',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    '${DateTimeUtils.currentDate} ${DateTimeUtils.currentMonth}',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  ),

                  Container(
                    height: 16.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 42.0),
                    child: Text(
                      'TODAY : FEBURARY 13, 2019',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.white.withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: Firestore.instance
                .collection('Plants')
                .document(widget.collname)
                .collection('Tasks')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return Expanded(
                flex: 2,
                child: new ListView(
                  children: <Widget>[
                    // _showPage,
                    // HomeTopInfo(),
                    new Container(
                        height: 420,
                        alignment: Alignment.center,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 30.0,
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      new CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              Productdetails(
                                                iitemName: snapshot.data
                                                    .documents[index]['name'],
                                                day1: snapshot.data
                                                    .documents[index]['day1'],
                                                day2: snapshot.data
                                                    .documents[index]['day2'],
                                                day3: snapshot.data
                                                    .documents[index]['day3'],
                                                day4: snapshot.data
                                                    .documents[index]['day4'],
                                                day5: snapshot.data
                                                    .documents[index]['day5'],
                                                day6: snapshot.data
                                                    .documents[index]['day6'],
                                                day7: snapshot.data
                                                    .documents[index]['day7'],
                                                iitemImage:
                                                    storeItems[index].itemImage,
                                                iitemDesc:
                                                    storeItems[index].itemDesc,
                                                iitemprice:
                                                    "RS ${storeItems[index].itemPrice}",
                                              ))),
                                  child: Container(
                                    width: 275,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300],
                                            offset: Offset(1, 1),
                                            blurRadius: 4)
                                      ],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12.0),
                                          bottomRight: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                          topLeft: Radius.circular(12.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 60, left: 10.0, right: 7.0),
                                      child: Column(
                                        children: <Widget>[
                                          //           new Text(storeItems[index].itemName),
                                          // new Text("N${storeItems[index].itemPrice}"),
                                          // new Image.asset(
                                          //     storeItems[index].itemImage),
                                          new Text(snapshot
                                              .data.documents[index]['name']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
