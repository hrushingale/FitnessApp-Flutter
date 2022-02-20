import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rootallyassignment/BarChartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:rootallyassignment/main.dart';



class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

double accuracy_s1=0;
double rangeofmotion=0;
int set1_legraise_complete=0;
int set1_legraise_incomplete=0;
int set2_legraise_complete=0;
int set2_legraise_incomplete=0;
int set3_legraise_complete=0;
int set3_legraise_incomplete=0;



class _SessionScreenState extends State<SessionScreen> {

  @override
  void initState(){
    super.initState();
    getSessionDetails();
    legRaiseDetails();
  }


  DatabaseReference sessionsReference=FirebaseDatabase.instance.ref("Users/Jane/Sessions");
  DatabaseReference legRaisesReference=FirebaseDatabase.instance.ref("Users/Jane/Sessions/1/leg_raise");

  List<BarChartModel> dataCompleted=[];
  List<BarChartModel> dataIncomplete=[];

  TextStyle exerciseStyle=TextStyle(fontSize: 18,fontWeight: FontWeight.bold);


  void getSessionDetails(){

    sessionsReference.get().then((dataSnapshot){
      setState(() {
        accuracy_s1=double.parse(dataSnapshot.child("1").child("Accuracy").value.toString());
        rangeofmotion=accuracy_s1;
      });
     print(accuracy_s1);
    }
    );

  }
  void legRaiseDetails(){
    legRaisesReference.get().then((dataSnapshot){
      setState(() {
        set1_legraise_incomplete=int.parse(dataSnapshot.child("Set_1").child("Incomplete").value.toString());
        set1_legraise_complete=int.parse(dataSnapshot.child("Set_1").child("Complete").value.toString());
        set2_legraise_complete=int.parse(dataSnapshot.child("Set_2").child("Complete").value.toString());
        set2_legraise_incomplete=int.parse(dataSnapshot.child("Set_2").child("Incomplete").value.toString());
        set3_legraise_complete=int.parse(dataSnapshot.child("Set_3").child("Complete").value.toString());
        set3_legraise_incomplete=int.parse(dataSnapshot.child("Set_3").child("Incomplete").value.toString());
        print(set1_legraise_incomplete);
        print(set1_legraise_complete);
        print(set2_legraise_complete);
        print(set2_legraise_incomplete);
        print(set3_legraise_complete);
        print(set3_legraise_incomplete);
        dataCompleted=[

          BarChartModel(set: "Set 1", reps: set1_legraise_complete, color: charts.ColorUtil.fromDartColor(Colors.greenAccent)),
          BarChartModel(set: "Set 3", reps: set2_legraise_complete, color: charts.ColorUtil.fromDartColor(Colors.greenAccent)),
          BarChartModel(set: "Set 4", reps: set3_legraise_complete, color: charts.ColorUtil.fromDartColor(Colors.greenAccent)),
        ];

        dataIncomplete=[
          BarChartModel(set: "Set 1", reps: set1_legraise_incomplete, color: charts.ColorUtil.fromDartColor(Colors.red)),
          BarChartModel(set: "Set 3", reps: set2_legraise_incomplete, color: charts.ColorUtil.fromDartColor(Colors.red)),
          BarChartModel(set: "Set 4", reps: set3_legraise_incomplete, color: charts.ColorUtil.fromDartColor(Colors.red)),
        ];
      });


    });




  }






  @override
  Widget build(BuildContext context) {


    List<charts.Series<BarChartModel, String>> completed = [
      charts.Series(
        id: "reps",
        data: dataCompleted,
        domainFn: (BarChartModel series, _) => series.set,
        measureFn: (BarChartModel series, _) => series.reps,
        colorFn: (BarChartModel series, _) => series.color,
      ),
      charts.Series(
        id: "reps",
        data: dataIncomplete,
        domainFn: (BarChartModel series, _) => series.set,
        measureFn: (BarChartModel series, _) => series.reps,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];
    // getSessionDetails();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[
            
            Column(
              children: [
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                    child: Column(
                      children: [
                        Text("You did amazing!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Session 1 Complete",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Image.asset("images/blue_tick.png",
                              width: 30,height: 30,
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 200,
                          child: Stack(
                              children:[
                                Center(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: new CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                      value: accuracy_s1/100,
                                      strokeWidth: 10,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Accuracy \n$accuracy_s1",
                                    textAlign:TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ),
                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(onPressed: (){},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),
                                    shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        )
                                    )
                                ),
                                child:
                                Row(
                                  children: [
                                    Icon(Icons.play_circle_fill, color: Colors.blue,),
                                    SizedBox(width: 5,),
                                    Text("Play Video",
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                  ],
                                )


                            ),
                            ElevatedButton(onPressed: (){},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        )
                                    )
                                ),
                                child:
                                Row(
                                  children: [
                                    Image.asset("images/analytics.png",width: 20,height: 30,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text("Analytics",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                )


                            )
                          ],

                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Set Details", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [Icon(Icons.circle, color: Colors.greenAccent,),Text("Complete",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,)],),
                                Row(children: [Icon(Icons.circle, color: Colors.yellowAccent,),Text("Skipped",style: TextStyle(fontSize: 12),textAlign: TextAlign.left)],),
                                Row(children: [Icon(Icons.circle, color: Colors.redAccent,),Text("Incomplete",style: TextStyle(fontSize: 12),textAlign: TextAlign.left)],),

                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            ExpandableNotifier(child: Column(

                              children: [
                                Expandable(

                                    collapsed: ExpandableButton(

                                        child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.black12,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurStyle: BlurStyle.outer,
                                                      blurRadius: 25,
                                                      spreadRadius: 10
                                                  )
                                                ],

                                                border: Border.all(
                                                  color: Colors.black26,
                                                  // width: 2,
                                                  // style: BorderStyle.solid
                                                ),
                                                borderRadius: BorderRadius.circular(7)
                                            ),

                                            width: 350,
                                            height: 50,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(width: 15,),
                                                Text("Leg Raise",style: exerciseStyle,),
                                                SizedBox(width: 80,),
                                                Text("Sets",style: TextStyle(fontSize: 16,color: Colors.black38, fontWeight: FontWeight.bold),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.alarm_on_rounded,color: Colors.greenAccent,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.fast_forward,color: Colors.yellow,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.clear,color: Colors.red,),
                                                SizedBox(width: 15,),
                                                Icon(Icons.keyboard_arrow_down_outlined),

                                              ],
                                            )
                                        )
                                    ),
                                    expanded: Column(
                                      children: [
                                        Container(
                                          width: 350,
                                          height: 200,
                                          color: Colors.black12,
                                          child: Column(
                                              children:[
                                                Container(
                                                  color: Colors.white60,
                                                  height: 30,
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(width: 15,),
                                                      Text("Leg Raise",style: exerciseStyle,),
                                                      SizedBox(width: 80,),
                                                      Text("Sets",style: TextStyle(fontSize: 16,color: Colors.black38, fontWeight: FontWeight.bold),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.alarm_on_rounded,color: Colors.greenAccent,),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.fast_forward,color: Colors.yellow,),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.clear,color: Colors.red,),
                                                      SizedBox(width: 15,),
                                                      Icon(Icons.keyboard_arrow_down_outlined),

                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: 250,
                                                    height: 70,
                                                    // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                                                    child:
                                                    charts.BarChart(

                                                      completed,
                                                      animate: true,
                                                      vertical: true,

                                                    ),

                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                    children:[

                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white54,
                                                        ),
                                                        width: 100,
                                                        child: Row(

                                                          children: [
                                                            SizedBox(width: 15,),
                                                            Column(
                                                              children: [
                                                                Text("Set 1",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("Min"),
                                                                Text("Max"),
                                                                Text("Avg")
                                                              ],
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            ),
                                                            SizedBox(width: 20,),
                                                            Column(
                                                              children: [
                                                                Text("",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion")
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white54,
                                                        ),
                                                        width: 100,
                                                        child: Row(

                                                          children: [
                                                            SizedBox(width: 15,),
                                                            Column(
                                                              children: [
                                                                Text("Set 3",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("Min"),
                                                                Text("Max"),
                                                                Text("Avg")
                                                              ],
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            ),
                                                            SizedBox(width: 20,),
                                                            Column(
                                                              children: [
                                                                Text("",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion")
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white54,
                                                        ),
                                                        width: 100,
                                                        child: Row(

                                                          children: [
                                                            SizedBox(width: 15,),
                                                            Column(
                                                              children: [
                                                                Text("Set 4",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("Min"),
                                                                Text("Max"),
                                                                Text("Avg")
                                                              ],
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            ),
                                                            SizedBox(width: 20,),
                                                            Column(
                                                              children: [
                                                                Text("",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion"),
                                                                Text("$rangeofmotion")
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                      ),



                                                    ]

                                                ),
                                                SizedBox(height: 10,)





                                              ]
                                          ),
                                        ),
                                        ExpandableButton(
                                            child: Icon(Icons.keyboard_arrow_up_outlined)
                                        )
                                      ],
                                    )),

                              ],
                            )),
                            SizedBox(height: 10,),
                            ExpandableNotifier(child: Column(
                              children: [
                                Expandable(
                                    collapsed: ExpandableButton(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white60,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(7)
                                            ),

                                            width: 350,
                                            height: 50,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(width: 15,),
                                                Text("Knee Bend",style: exerciseStyle,),
                                                SizedBox(width: 75,),
                                                Text("Sets",style: TextStyle(fontSize: 16,color: Colors.black38, fontWeight: FontWeight.bold),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.alarm_on_rounded,color: Colors.greenAccent,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.fast_forward,color: Colors.yellow,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.clear,color: Colors.red,),
                                                SizedBox(width: 15,),
                                                Icon(Icons.keyboard_arrow_down_outlined),
                                              ],
                                            )
                                        )
                                    ),
                                    expanded: Column(
                                      children: [
                                        Container(
                                          width: 350,
                                          height: 150,
                                          color: Colors.grey,
                                          child: Center(child: Text("<Blank>")),
                                        ),
                                        ExpandableButton(
                                          child: Icon(Icons.keyboard_arrow_up_outlined),
                                        )
                                      ],
                                    )),

                              ],
                            )),
                            SizedBox(height: 10,),
                            ExpandableNotifier(child: Column(
                              children: [
                                Expandable(
                                    collapsed: ExpandableButton(
                                        child: Container(

                                            decoration: BoxDecoration(
                                                color: Colors.white60,

                                                border: Border.all(

                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(7)
                                            ),

                                            width: 350,
                                            height: 50,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(width: 15,),
                                                Text("Hamstring Stretch",style: exerciseStyle,),
                                                SizedBox(width: 15,),
                                                Text("Sets",style: TextStyle(fontSize: 16,color: Colors.black38, fontWeight: FontWeight.bold),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.alarm_on_rounded,color: Colors.greenAccent,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.fast_forward,color: Colors.yellow,),
                                                SizedBox(width: 5,),
                                                Icon(Icons.clear,color: Colors.red,),
                                                SizedBox(width: 15,),
                                                Icon(Icons.keyboard_arrow_down_outlined),

                                              ],
                                            )
                                        )
                                    ),
                                    expanded: Column(
                                      children: [
                                        Container(
                                          width: 350,
                                          height: 150,
                                          color: Colors.grey,
                                          child: Center(child: Text("<Blank>")),
                                        ),
                                        ExpandableButton(
                                          child: Icon(Icons.keyboard_arrow_up_outlined),
                                        )
                                      ],
                                    )),

                              ],
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ]
        ),
      ),
      
      
    );
  }
}

