import 'package:flutter/material.dart';
import 'package:kitapozetiapp/summary_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  List test = [1,2,3];
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.search, size: 32,))
        ],
        title: Text("Kitap Özetleri"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: GridView.count(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          children: List.generate(kitapOzetleri.length, (index) {
            return Padding(child: GestureDetector(
            child:
            Container(
              alignment: Alignment.center,
            height: 10, width: 10,
            child: Text(kitapOzetleri.keys.elementAt(index), textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, ),),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/cover.jpg'),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(12), color: Colors.blue.shade200)),

            onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
      title: Text(kitapOzetleri.keys.elementAt(index), style: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
      content: Text(kitapOzetleri.values.elementAt(index),
      style: TextStyle(
        fontSize: 18
      ),),
      actions: <Widget>[
      TextButton(
      onPressed: () => Navigator.pop(context, 'OK'),
      child: const Text('OK'),
      ),
      ],
      ),
      ),
      ),

      padding: EdgeInsets.all(15),);
      },
        ),
      ),
    ));
  }
}
