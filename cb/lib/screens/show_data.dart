import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civilion Business'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.login),
          )
        ],
      ),
      body: const Column(),
    );
  }
}
