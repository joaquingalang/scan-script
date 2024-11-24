import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_script/main.dart';
import 'package:scan_script/screens/findings_screen.dart';
import 'package:scan_script/screens/regexp_info_screen.dart';
import 'package:scan_script/services/constants.dart';
import 'package:scan_script/widgets/bottom_sheets.dart';
import 'package:scan_script/widgets/regex_card.dart';
import 'package:scan_script/services/scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Scanner ocrScanner = Scanner();
  List<String> regExpList = [];

  void _addRegExp(String newRegExp) {
    print(newRegExp);
    setState(() {
      regExpList.add(newRegExp);
    });
  }

  void _deleteRegExp(int index) {
    setState(() {
      regExpList.removeAt(index);
    });
  }

  void _editRegExp(int index, String regExp) {
    setState(() {
      regExpList[index] = regExp;
    });
  }

  void _editInterface(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditRegExpInterface(
          index: index,
          regExp: regExpList[index],
          action: _editRegExp,
        ),
      ),
    );
  }

  void _displayBody(List<String> body) {
    for (String line in body) {
      print(line);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // bottomNavigationBar: BottomNavigationBar(items: items),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(90),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.document_scanner_outlined,
                          color: kPrimaryColor,
                          size: 60,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegExpInfoScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'ScanScript',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${regExpList.length} Regular Expressions',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: (regExpList.isEmpty)
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add a RegExp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_downward_rounded,
                          color: Colors.grey,
                          size: 60,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: regExpList.length,
                      itemBuilder: (context, index) {
                        return RegExpCard(
                          title: regExpList[index],
                          delete: () {
                            _deleteRegExp(index);
                          },
                          edit: (){
                            _editInterface(index);
                          },
                        );
                      },
                    ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
            color: Colors.grey,
            width: 1,
          )),
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                  List<String>? body =
                      await ocrScanner.pickImage(ImageSource.camera);
                  // if (body == null) Navigator.pop(context);
                  _displayBody(body!);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindingsScreen(
                        body: body,
                        regExpList: regExpList,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.grey,
                  size: 45,
                ),
              ),
              const SizedBox(width: 150),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                  List<String>? body =
                      await ocrScanner.pickImage(ImageSource.gallery);
                  _displayBody(body!);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindingsScreen(
                        body: body,
                        regExpList: regExpList,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.grey,
                  size: 45,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        shape: const CircleBorder(),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddRegExpInterface(
                action: _addRegExp,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 70,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
