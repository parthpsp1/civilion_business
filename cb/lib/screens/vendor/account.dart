import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorAccountScreen extends StatelessWidget {
  const VendorAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'You are logged in as',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(CustomFireBaseAuth().currentUser?.email ?? 'No email'),
          )
        ],
      ),
    );
  }
}
