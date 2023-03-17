import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo(
      {super.key,
      required this.row,
      required this.col,
      required this.alphabet});
  final int row;
  final int col;
  final String alphabet;

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  TextEditingController compare = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> alp = widget.alphabet.split('');

    List<String> comp = compare.text.split('');
    comp.add(0.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: compare,
                ),
                const SizedBox(height: 25),
                ValueListenableBuilder(
                  valueListenable: compare,
                  builder: (BuildContext context, value, Widget? child) {
                    String text = compare.text;
                    List<String> comp = text.split('');
                    comp.add(0.toString());
                    List<int> indices = List.generate(
                        text.length, (index) => alp.indexOf(text[index]));

                    bool isMatchingDown = true;
                    bool isMatchingDiagonal = true;
                    bool isMatchingStraight = true;

                    if (indices.length >= widget.col) {
                      int firstIndex = indices[0];
                      int colDiff = firstIndex % widget.col;
                      int rowDiff = firstIndex ~/ widget.col;

                      for (int i = 1; i < indices.length; i++) {
                        int index = indices[i];
                        int colDiff2 = index % widget.col;
                        int rowDiff2 = index ~/ widget.col;
                        if (colDiff2 - colDiff != rowDiff2 - rowDiff) {
                          isMatchingDiagonal = false;
                        }
                        if (index != firstIndex + i) {
                          isMatchingStraight = false;
                        }
                        if (colDiff2 != colDiff) {
                          isMatchingDown = false;
                        }
                      }
                    } else {
                      isMatchingDown = false;
                      isMatchingDiagonal = false;
                      isMatchingStraight = false;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 2,
                          crossAxisCount: widget.col,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        bool isGreen = false;
                        bool isRed = false;
                        if (comp.contains(alp[index])) {
                          if (isMatchingDiagonal ||
                              isMatchingStraight ||
                              isMatchingDown) {
                            isGreen = true;
                            isRed = false;
                          } else {
                            isRed = true;
                          }
                        } else {
                          isGreen = false;
                        }

                        Color color;
                        if (isGreen) {
                          color = Colors.green;
                        } else if (isRed) {
                          color = Colors.red;
                        } else {
                          color = Colors.lightBlue.shade100;
                        }
                        return Container(
                          color: color,
                          child: Center(
                            child: Text(alp[index]),
                          ),
                        );
                      },
                      itemCount: widget.row * widget.col,
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
