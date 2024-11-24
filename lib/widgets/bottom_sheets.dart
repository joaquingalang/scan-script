import 'package:flutter/material.dart';
import 'package:scan_script/services/constants.dart';

class AddRegExpInterface extends StatelessWidget {

  AddRegExpInterface({super.key, required this.action});

  final void Function(String)? action;

  final TextEditingController _regexpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Add RegExp',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _regexpController,
              cursorColor: kPrimaryColor,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
              ),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),

            ),
            GestureDetector(
              onTap: (){
                action!(_regexpController.text);
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'ADD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EditRegExpInterface extends StatefulWidget {

  EditRegExpInterface({super.key, required this.index, required this.regExp, required this.action});

  final int index;
  final String regExp;
  final void Function(int, String)? action;

  @override
  State<EditRegExpInterface> createState() => _EditRegExpInterfaceState();
}

class _EditRegExpInterfaceState extends State<EditRegExpInterface> {
  final TextEditingController _regexpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _regexpController.text = widget.regExp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Edit RegExp',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _regexpController,
              cursorColor: kPrimaryColor,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
              ),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 2,
                  ),
                ),
              ),

            ),
            GestureDetector(
              onTap: (){
                widget.action!(widget.index, _regexpController.text);
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'EDIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
