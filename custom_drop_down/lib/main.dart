import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String condition = 'Condition of Item';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Drop Down'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isDense: true,
              isExpanded: true,
              hint: Text(
                condition,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  condition = newValue.toString();
                });
              },
              items: [
                DropdownMenuItem(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'New',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Items that are brand new, never used, with the tags still attached.',
                        ),
                      ],
                    ),
                  ),
                  value: 'New',
                ),
                DropdownMenuItem(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Used',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Items that are used.',
                        ),
                      ],
                    ),
                  ),
                  value: 'Used',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
