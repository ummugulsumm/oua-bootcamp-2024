import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

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
        title: Text("Kitap Özetleri"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
          itemBuilder: (context, index) => Padding(child: GestureDetector(
            child:
            Container(
                height: 10, width: 10,
                child: Align(child: Text("Kitap İsmi X",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),), alignment: Alignment.center,),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.blue.shade200)),

            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Kitap İsmi'),
                content: const Text('Kitap Özeti'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),

            padding: EdgeInsets.all(15),),
          itemCount: 12,
        ),
      ),
    );
  }
}
