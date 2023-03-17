import 'package:flutter/material.dart';
import 'package:machinetest/screen_two.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  TextEditingController row = TextEditingController();
  TextEditingController col = TextEditingController();
  TextEditingController alphabet = TextEditingController();

  bool isSameLetter() {
    String text = alphabet.text;
    for (int i = 0; i < text.length - 1; i++) {
      if (text[i] == text[i + 1]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: RichText(
            text: const TextSpan(
              text: 'WordOx',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                ' FILL THE FORM,',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ROW',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: row,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'COLUMN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: col,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ALPHABET',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: alphabet,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(100, 50),
                      shadowColor: Colors.blueGrey,
                    ),
                    onPressed: () {
                      if (row.text.isNotEmpty &&
                          col.text.isNotEmpty &&
                          alphabet.text.isNotEmpty &&
                          !isSameLetter()) {
                        int rrr = int.parse(row.text);
                        int ccc = int.parse(col.text);
                        if (rrr * ccc == alphabet.text.length) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => ScreenTwo(
                                col: int.parse(col.text),
                                row: int.parse(row.text),
                                alphabet: alphabet.text),
                          ))
                              .then((value) {
                            col.clear();
                            row.clear();
                            alphabet.clear();
                            return null;
                          });
                        } else if (rrr * ccc != alphabet.text.length) {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  'Alphabets should be equal to ROW * COLUMN',
                            ),
                          );
                        }
                      } else if (isSameLetter()) {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: 'Each Alphabet should be different',
                          ),
                        );
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: 'Please fill the form',
                          ),
                        );
                      }
                    },
                    child: const Text('DONE')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
