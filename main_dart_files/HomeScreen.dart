

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:rootallyassignment/BarChartModel.dart';
import 'package:rootallyassignment/SesssionScreen.dart';
import 'package:rootallyassignment/widgets/customicons.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState(){
    super.initState();
    getData();

  }

  int progressPercent=0;
  String completedSessions="";
  String pendingSessions="";
  int selectedIndex=0;
  String sessionNo="";
  String sessionStatus="";
  String sessionRetry="";
  String sessionTime="";
  List<Widget> _cardList=[];

  DatabaseReference userReference=FirebaseDatabase.instance.ref("Users/Jane");
  DatabaseReference sessionsReference=FirebaseDatabase.instance.ref("Users/Jane/Sessions");


  Future<void> getData() async {
      userReference.get().then((dataSnapshot){
        setState(() {
          completedSessions=dataSnapshot.child("Completed").value.toString();
          pendingSessions=dataSnapshot.child("Pending").value.toString();
          progressPercent=int.parse(dataSnapshot.child("Progress").value.toString());
        });

    });

    sessionsReference.get().then((dataSnapshot){
      setState(() {
        for(DataSnapshot ds in dataSnapshot.children){
          sessionNo=ds.key.toString();
          sessionStatus=ds.child("Status").value.toString();
          sessionRetry=ds.child("Retry").value.toString();
          sessionTime=ds.child("Time").value.toString();
          print(sessionNo);
          print(sessionStatus);
          _cardList.add(showSession(sessionNo,sessionStatus,sessionRetry,sessionTime));
        }
      });
    });
  }

  Widget showSession(String sNo, String status, String retry, String time){
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 350,
          height: 130,

          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: 5,),
                    Text("Session $sNo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),),
                    Container(
                        width: 130,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(
                                color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),

                        child: Align(
                            alignment: Alignment.center,
                            child: Text("$status", style: TextStyle(fontSize: 15,color: Colors.black),)
                        )
                    ),
                    SizedBox(height: 5,),
                    Text("Performed At", style: TextStyle(fontSize: 13,color: Colors.black54),),
                    Text("8:12 AM", style: TextStyle(fontSize: 15,color: Colors.black54),),

                  ],
                ),
                Image.asset("images/sessionimage.png", width: 100, height: 100,)
              ],
            ),

          ),
        ),

    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
            appBar: AppBar(
            title: const Text("Home Screen"),
          ),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              size: 30,
              opacity: 100
            ),

            unselectedIconTheme: IconThemeData(
                size: 20,
                opacity: 50
            ),

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Colors.black54,),
                  label: 'Home',
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility,color: Colors.black54,),
                  label: 'Rehab',
              ),

              BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.compass,color: Colors.black54,),
                  label: 'Practice',
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: Colors.black54,),

                  label: 'Profile'
              )

            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          body: SingleChildScrollView(
            child: Column(
              children:[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 30,),
                            Text(
                              "Good Morning"
                                  "\nUser",
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        borderOnForeground: true,
                        shadowColor: Colors.black,
                        color: Colors.white30,
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Today's Progress",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${progressPercent}%",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              width: MediaQuery.of(context).size.width*0.8,
                              height: 10,
                              child: LinearProgressIndicator(
                                color: Colors.blue,
                                backgroundColor: Colors.grey,
                                minHeight: 5,
                                value: progressPercent/100,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("images/checked.png", height: 40, width: 40,),
                                    SizedBox(width: 5,),
                                    Text("Completed\n$completedSessions Sessions",textAlign: TextAlign.center,)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("images/pending.png", height: 40, width: 40,),
                                    SizedBox(width: 5,),
                                    Text("Pending\n$pendingSessions Sessions",textAlign: TextAlign.center,),
                                  ],

                                )
                              ],

                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _cardList.length,
                          itemBuilder: (context,index){
                            return _cardList[index];
                          }),


                    ],

                  ),
                ),

              ]
            ),
          ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 45),
          width: 270,
          height: 70,
          child: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> const SessionScreen()));
            },
            label: Text("Start Session",
            style: TextStyle(fontSize: 20,color: Colors.black),),
            icon: Icon(Icons.play_arrow,color: Colors.black,),


          ),
        ),
      ),

    );

  }
}
