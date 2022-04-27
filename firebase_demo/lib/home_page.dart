import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  List<Chant> names = [];
  late CollectionReference<Map<String, dynamic>> chantsCollection;
  String? name;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode powerFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    chantsCollection = FirebaseFirestore.instance.collection('chants');
    _getDocuments(chantsCollection);
  }

  @override
  void didChangeDependencies() {
    print('did didChangeDependencies ran');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildFormView(),
                  Expanded(
                    child: _buildList(),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    powerController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildFormView() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              focusNode: nameFocusNode,
              controller: nameController,
              validator: (value) {},
            ),
            TextFormField(
              focusNode: powerFocusNode,
              controller: powerController,
              validator: (value) {},
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                _addToDatabase();
                print('Name: ${nameController.text}');
                print('Power: ${powerController.text}');
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToDatabase() async {
    if (nameController.text.isNotEmpty && powerController.text.isNotEmpty) {
      await chantsCollection.add({
        'Name': nameController.text.trim(),
        'power': powerController.text.trim(),
      });
      nameController.text = '';
      powerController.clear();
      if (powerFocusNode.hasFocus) {
        powerFocusNode.unfocus();
      }
      if (nameFocusNode.hasFocus) {
        nameFocusNode.unfocus();
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Field should not be empty.',
      );
    }
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

class DemoWidget extends StatelessWidget {
  const DemoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
