import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widget/attend_bottom_sheet.dart';
import '../widget/maps.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: MediaQuery.of(context).size.height * 0.10,
            right: 0,
            left: 0,
            child: const MapsWidget(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    // spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: const AttendBottomSheet(),
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.15,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.goNamed('menu'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.menu),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
