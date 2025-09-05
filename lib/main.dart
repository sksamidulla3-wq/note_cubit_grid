import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (ctx, index) {
            return GridTile(
              child: InkWell(
                onTap: (){},
                child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   border: BoxBorder.all(color: Colors.black),
                   color: Colors
                     .primaries[random.nextInt(Colors.primaries.length)]
                  .shade300,
                 ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                          child: Text("Title")),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("Time")),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.delete,size: 18,color: Colors.red,))),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
