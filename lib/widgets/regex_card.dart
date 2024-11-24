import 'package:flutter/material.dart';

class RegExpCard extends StatelessWidget {
  const RegExpCard({
    super.key,
    required this.title,
    required this.delete,
    required this.edit,
  });

  final String? title;
  final void Function() delete;
  final void Function() edit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: edit,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: delete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}