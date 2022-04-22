import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chant man',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  List<Chant> names = [];
  String? name;
  @override
  void initState() {
    super.initState();
    final chants = FirebaseFirestore.instance.collection('chants');
    _getDocuments(chants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...names
                        .map((chant) => Card(
                              elevation: 12.0,
                              child: ListTile(
                                title: Text(chant.name),
                                subtitle: Text(chant.power),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _getDocuments(
      CollectionReference<Map<String, dynamic>> chants) async {
    final ref = await chants.get();
    final newList = ref.docs
        .map(
          (e) => Chant(
            e.data()['Name'] as String,
            e.data()['power'] as String,
          ),
        )
        .toList();
    setState(() {
      names.addAll([...newList]);
      setState(() {
        isLoading = false;
      });
    });

    _listenToChantCollection(chants);
  }

  void _listenToChantCollection(
      CollectionReference<Map<String, dynamic>> chants) {
    final chantStream = chants.snapshots();
    chantStream.listen((value) {
      final newChant = Chant(
        value.docs.last.data()['Name'] as String,
        value.docs.last.data()['power'] as String,
      );
      if (!names.any((chant) => chant.name == newChant.name)) {
        setState(() {
          names.add(newChant);
        });
      }
    });
  }
}

class Chant {
  final String name;
  final String power;

  Chant(this.name, this.power);
}
