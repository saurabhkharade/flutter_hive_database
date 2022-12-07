import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
                future: Hive.openBox('hive_database'),
                builder: (context, AsyncSnapshot snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text("Name:- ${snapshot.data!.get('name')}"),
                          subtitle: Text(
                              "Address:- ${snapshot.data!.get('address')}"),
                          trailing: IconButton(
                            onPressed: () {
                              snapshot.data!.delete('address');
                              setState(() {

                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('hive_database');
          box.put('name', 'Saurabh');
          box.put('address', 'Raigad');
          box.put('age', '26');
          box.put('email', 'saurabh@gmail.com');
          box.put(
              'details', {'eduction': 'Diploma', 'pro': 'Android developer'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
