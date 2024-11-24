import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scan_script/services/constants.dart';

class RegExpInfoScreen extends StatelessWidget {
  final List<Map<String, String>> regexSymbols = [
    {
      'Symbol': '.',
      'Description': 'Matches any single character except a newline'
    },
    {'Symbol': '^', 'Description': 'Matches the start of a string'},
    {'Symbol': '\$', 'Description': 'Matches the end of a string'},
    {
      'Symbol': '*',
      'Description': 'Matches 0 or more of the preceding character'
    },
    {
      'Symbol': '+',
      'Description': 'Matches 1 or more of the preceding character'
    },
    {'Symbol': '?', 'Description': 'Matches 0 or 1 of the preceding character'},
    {
      'Symbol': '{n}',
      'Description': 'Matches exactly n occurrences of the preceding character'
    },
    {
      'Symbol': '{n,}',
      'Description': 'Matches n or more occurrences of the preceding character'
    },
    {
      'Symbol': '{n,m}',
      'Description':
          'Matches between n and m occurrences of the preceding character'
    },
    {
      'Symbol': '[]',
      'Description': 'Matches any one character inside the brackets'
    },
    {
      'Symbol': '[^]',
      'Description': 'Matches any one character not inside the brackets'
    },
    {'Symbol': '\\', 'Description': 'Escapes a special character'},
    {'Symbol': '\\d', 'Description': 'Matches any digit (0-9)'},
    {'Symbol': '\\D', 'Description': 'Matches any non-digit'},
    {
      'Symbol': '\\w',
      'Description': 'Matches any word character'
    },
    {'Symbol': '\\W', 'Description': 'Matches any non-word character'},
    {
      'Symbol': '\\s',
      'Description': 'Matches any whitespace character'
    },
    {'Symbol': '\\S', 'Description': 'Matches any non-whitespace character'},
    {'Symbol': '|', 'Description': 'Alternation (logical OR)'},
    {'Symbol': '()', 'Description': 'Grouping of expressions'},
    {'Symbol': '(?:...)', 'Description': 'Non-capturing group'},
    {'Symbol': '(?=...)', 'Description': 'Positive lookahead'},
    {'Symbol': '(?!...)', 'Description': 'Negative lookahead'},
    {'Symbol': '(?<=...)', 'Description': 'Positive lookbehind'},
    {'Symbol': '(?<!...)', 'Description': 'Negative lookbehind'},
    {'Symbol': '\\b', 'Description': 'Word boundary'},
    {'Symbol': '\\B', 'Description': 'Non-word boundary'},
  ];

  _launchURL() async {
    final Uri url = Uri.parse('https://en.wikipedia.org/wiki/Regular_expression');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        )),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
        title: Text(
          'Information',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'RegExp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'A regular expression (often abbreviated as regex or regexp) is a sequence of characters that defines a search pattern. It is a powerful tool used for string matching and manipulation in text processing.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: TextButton(
                            onPressed: _launchURL,
                            child: Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Text(
                                  'Learn More',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Finite Automata',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('images/transition_diagram.png'),
            const Text(
              ' \u2022 Finite Automata can be constructed to represent any regular expression.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const Text(
              ' \u2022 These automata can process strings, step-by-step, to determine if they match a pattern described by a regular expression.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const Text(
              ' \u2022 Automata help in converting regular expressions into visual diagrams (like transition diagrams) or into a structured representation called a transition table.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Metacharacters',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            DataTable(
              border: TableBorder.all(color: Colors.grey, width: 2),
              columns: const [
                DataColumn(
                  label: Text('Symbol'),
                ),
                DataColumn(label: Text('Description')),
              ],
              rows: regexSymbols.map((symbolInfo) {
                return DataRow(cells: [
                  DataCell(Text(symbolInfo['Symbol']!)),
                  DataCell(Text(symbolInfo['Description']!)),
                ]);
              }).toList(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
