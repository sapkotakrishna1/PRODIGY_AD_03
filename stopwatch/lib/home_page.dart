import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  int s = 0, m = 0, h = 0;
  var digSec = "00", digMin = "00", digHr = "00";
  Timer? timer;
  bool started = false;

  List laps = [];

  // stop Function

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // reset Function

  void reset() {
    timer!.cancel();
    setState(() {
      s = 0;
      m = 0;
      h = 0;
      digSec = "00";
      digMin = "00";
      digHr = "00";
      laps.clear();
      started = false;
    });
  }

  // adding Laps Function

  void addlap() {
    var lap = "$digHr:$digMin:$digSec";
    setState(() {
      laps.add(lap);
    });
  }

  //  start Function

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localsec = s + 1;
      int localmin = m;
      int localhours = h;
      if (localsec > 59) {
        if (localmin > 59) {
          localhours++;
          localmin = 0;
        } else {
          localmin++;
          localsec = 0;
        }
      }

      setState(() {
        s = localsec;
        m = localmin;
        h = localhours;

        digSec = (s >= 10) ? "$s" : "0$s";
        digMin = (m >= 10) ? "$m" : "0$m";
        digHr = (h >= 10) ? "$h" : "0$h";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 159, 196),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'StopWatch App',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 42, 43, 48),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '$digHr:$digMin:$digSec',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 55.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                      // color: Color(0xFF313E66),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap ${index + 1}",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              Text(
                                "${laps[index]}",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    fillColor: const Color.fromARGB(255, 23, 58, 87),
                    shape: const StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 60, 110, 150))),
                    child: Text(
                      (!started) ? "Start" : "Stop",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      addlap();
                    },
                    padding: const EdgeInsets.all(10),
                    icon: const Icon(
                      Icons.flag,
                      color: Color.fromARGB(255, 128, 64, 64),
                      size: 42,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: const Color.fromARGB(255, 23, 58, 87),
                    shape: const StadiumBorder(),
                    child: const Text(
                      'Restart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
