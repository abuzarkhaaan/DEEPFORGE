import 'dart:ui';

import 'package:deepforge_app/Providers/deep_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool Loading;
  Color color;

  RoundButton(
      {required this.title,
      required this.onTap,
      this.Loading = false,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 1,
                  color: Color.fromARGB(101, 158, 158, 158),
                  offset: Offset(1, 2)
                )]
              ),
              child: Loading
                  ? CircularProgressIndicator()
                  : Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ))),
    );
  }
}

class MoreButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool Loading;
  final Color color;

  MoreButton(
      {required this.title,
      required this.onTap,
      this.Loading = false,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 1,
                  color: Color.fromARGB(101, 158, 158, 158),
                  offset: Offset(1, 2)

                )]
              ),
              child: Consumer<DeepProvider>(builder: (context, provider, _) {
                return Center(
                    child: provider.isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 4, color: Colors.white)
                        : Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ));
              }))),
    );
  }
}
