import 'package:blur/blur.dart';
import 'package:cb/data/label.dart';
import 'package:cb/screens/data_screen.dart';
import 'package:flutter/material.dart';

class SpecialityScreen extends StatelessWidget {
  const SpecialityScreen({super.key, required this.vendorProfession});

  final String vendorProfession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Speciality'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemCount: LocalData.specialityLabels[vendorProfession]!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DataScreen(
                      vendorSpeciality:
                          LocalData.specialityLabels[vendorProfession]![index],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Blur(
                    blur: 0.4,
                    blurColor: Colors.black,
                    colorOpacity: 0.8,
                    overlay: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          bottom: 4,
                        ),
                        child: Text(
                          LocalData.specialityLabels[vendorProfession]![index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      'assets/logo/app_logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
