// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NotesClosed extends StatelessWidget {
  String? title;
  String? desc;

  NotesClosed({
    super.key,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(30, 255, 255, 255),
        ),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 13, 0, 0),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(45, 255, 255, 255),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  desc!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
