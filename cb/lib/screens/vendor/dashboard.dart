import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/screens/vendor/account.dart';
import 'package:cb/screens/vendor/add_data.dart';
import 'package:cb/screens/vendor/show_data.dart';
import 'package:cb/screens/login_screen.dart';
import 'package:flutter/material.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard'),
              automaticallyImplyLeading: false,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VendorAccountScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_circle_outlined),
                  label: const Text('Account'),
                ),
                TextButton.icon(
                  onPressed: () {
                    CustomFireBaseAuth().signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const VendorLoginScreen(),
                    ));
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                )
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'My Data',
                    icon: Icon(
                      Icons.folder_open_outlined,
                    ),
                  ),
                  Tab(
                    text: 'Add Data',
                    icon: Icon(
                      Icons.create_new_folder_outlined,
                    ),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              physics: PageScrollPhysics(),
              children: [
                ShowData(),
                AddData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
