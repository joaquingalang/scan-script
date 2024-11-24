import 'package:flutter/material.dart';
import 'package:scan_script/services/constants.dart';

class FindingsScreen extends StatelessWidget {
  const FindingsScreen(
      {super.key, required this.body, required this.regExpList});

  final List<String>? body;
  final List<String> regExpList;

  bool _checkMatches(String text, List<String> regExpList) {
    for (String expression in regExpList) {
      RegExp regExp = RegExp(expression, caseSensitive: false);
      if (regExp.hasMatch(text)) {
        return true;
      }
    }
    return false;
  }

  List<List<int>> _getMatchIndexList(String text, List<String> regExpList) {
    List<List<int>> matchIndexes = [];
    for (String expression in regExpList) {
      RegExp regExp = RegExp(expression, caseSensitive: false);
      Iterable<RegExpMatch> matches = regExp.allMatches(text);
      for (RegExpMatch match in matches) {
        matchIndexes.add([match.start, match.end]);
      }
    }
    return matchIndexes;
  }

  List<List<int>> _sortMatchIndexList(List<List<int>> matchIndexes) {
    List<List<int>> sortedList = matchIndexes;
    for (int i = 0; i < sortedList.length; i++) {
      // Assume the current position holds the minimum element
      int minIndex = i;

      // Find the actual minimum element
      for (int j = i + 1; j < sortedList.length; j++) {
        if (sortedList[j][0] < sortedList[minIndex][0]) {
          minIndex = j;
        }
      }

      List<int> firstItem = sortedList[i];
      sortedList[i] = sortedList[minIndex];
      sortedList[minIndex] = firstItem;
    }

    return sortedList;
  }

  List<List<int>> _mergeMatchIndexList(List<List<int>> sortedList) {
    List<List<int>> needsMerge = sortedList;
    List<List<int>> mergedList = [];

    while (true) {
      bool skipNext = false;
      for (int i = 1; i < needsMerge.length; i++) {
        if (skipNext) {
          skipNext = false;
          continue;
        }

        int first = i - 1;
        int second = i;
        if (needsMerge[first][1] >= needsMerge[second][0]) {
          int start = needsMerge[first][0];
          int end = needsMerge[second][1];
          mergedList.add([start, end]);
          skipNext = true;
        } else {
          mergedList.add(needsMerge[first]);
        }
      }

      print(mergedList);
      if (mergedList.isEmpty || mergedList[mergedList.length - 1][1] !=
          needsMerge[needsMerge.length - 1][1]) {
        mergedList.add(needsMerge[needsMerge.length - 1]);
      }

      if (_isMergeable(mergedList)) {
        needsMerge = mergedList;
        mergedList = [];
      } else {
        return mergedList;
      }
    }
  }

  bool _isMergeable(List<List<int>> mergedList) {
    for (int i = 0; i < mergedList.length - 1; i++) {
      int current = i;
      int next = i + 1;
      if (mergedList[current][1] >= mergedList[next][0]) {
        return true;
      }
    }
    return false;
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
          'Try Again',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
        child: ListView.builder(
          itemCount: body!.length,
          itemBuilder: (context, index) {

            String text = body![index].replaceAll('\n', ' ');

            if (_checkMatches(text, regExpList)) {
              print('THERE ARE MATCHES!');
              // Keep track of all match start and end indexes
              List<List<int>> matchIndexes =
                  _getMatchIndexList(text, regExpList);
              matchIndexes = _sortMatchIndexList(matchIndexes);
              matchIndexes = _mergeMatchIndexList(matchIndexes);
              List<TextSpan> spans = [];

              print('!!! $text !!!');
              print(matchIndexes);

              String span = '';
              print('Text Length: ${text.length}');

              for (int i = 0; i < text.length; i++) {
                if (matchIndexes.isNotEmpty) {
                  if (i == matchIndexes[0][0]) {
                    spans.add(
                      TextSpan(
                        text: span,
                      ),
                    );
                    span = text[i];
                  } else {
                    if (i == matchIndexes[0][1]) {
                      spans.add(
                        TextSpan(
                          text: span,
                          style: kHighlightedTextStyle,
                        ),
                      );
                      matchIndexes.removeAt(0);
                      span = '';
                    }
                    span += text[i];
                  }
                } else {
                  span += text[i];
                  if (i == text.length - 1) {
                    spans.add(
                      TextSpan(
                        text: span,
                      ),
                    );
                  }
                }
              }

              print(spans);


              print('ADDED TO THE SPANS');
              return RichText(
                text: TextSpan(
                  text: '\n',
                  style: kBodyTextStyle,
                  children: spans,
                ),
              );

            } else {
              return Text(
                '\n$text',
                style: kBodyTextStyle,
              );
            }
          },
        ),
      ),
    );
  }
}
