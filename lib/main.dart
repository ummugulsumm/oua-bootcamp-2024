import 'package:flutter/material.dart';
import 'package:kitapozetiapp/summary_repository.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'gemini_client.dart';

void main() {

  //init Gemini
  Gemini.init(apiKey: geminiApiKey);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  
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
  /// Search icin controller tuttuk.
  late TextEditingController _controller;
  final gemini = Gemini.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// init ettik.
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /// Yaptıktan sonra sifirladik.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Lütfen kitap ismini giriniz:", style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("${_controller.text} kitabının özeti: "),
                  content: FutureBuilder(
                    future: gemini.text("Summarize the ${_controller.text} book in Turkish.")
                        .then((value) => value?.output),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Text(snapshot.data.toString());
                      } else {
                        return const Text('No data');
                      }
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );

              },
            )
            , icon: Icon(Icons.send))
          ),
        ),
      ),
    ), icon: Icon(Icons.search, size: 32,))
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
