import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int s = 0, m = 0, h = 0;
  String digsec = "00", digmin = "00", dighr = "00";
  Timer? timer;
  bool started = false;

  List Laps = [];
  // Stop Function

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      s = 0;
      h = 0;
      m = 0;
      digsec = "00";
      digmin = "00";
      dighr = "00";
      started = false;
      Laps.clear();
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsec = s + 1;
      int localmin = m;
      int localhr = h;

      if (localsec > 59) {
        if (localmin > 59) {
          localhr++;
          localmin = 0;
        } else {
          localmin++;
          localsec = 0;
        }
      }

      setState(() {
        s = localsec;
        m = localmin;
        h = localhr;
        digsec = (s >= 10) ? "$s" : "0$s";
        digmin = (m >= 10) ? "$m" : "0$m";
        dighr = (h >= 10) ? "$h" : "0$h";
      });
    });
  }

  void addlaps() {
    String lap = "$dighr:$digmin:$digsec";
    setState(() {
      Laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(

                child:Container(
                  width: 250,
                  height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.blueAccent,
                      ),
                    color: Color(0XFF991F9), shape: BoxShape.circle,),
                    child: Center(
                      child: Text(
                        '$dighr:$digmin:$digsec',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 55.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),

              Expanded(
                child: Container(
                  height: 400.0,
                  child: ListView.builder(
                      itemCount: Laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap ${index + 1}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.blueAccent),
                              ),
                              Text(
                                "${Laps[index]}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),

                Padding(
                  padding: EdgeInsets.only(bottom: 50,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            (!started) ? start() : stop();
                          });
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.yellow[800]),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),


                        child: Text(
                          (!started) ? "Start" : "Stop",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                        IconButton(
                              onPressed: () {
                                addlaps();
                              },
                              icon: Icon(
                                Icons.flag,
                                color: Colors.blueAccent,
                                size: 35,
                              ),
                            ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.yellow[800]),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),






              // ),
            ],
          ),
        ),
      ),
    );
  }
}
