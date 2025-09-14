import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, TextEditingController>> subjects = [];

  @override
  void initState() {
    super.initState();
    addSubject();
  }

  void addSubject() {
    setState(() {
      subjects.add({
        'name': TextEditingController(),
        'credit': TextEditingController(),
        'grade': TextEditingController(),
      });
    });
  }

  void removeSubject(int index) {
    setState(() {
      subjects.removeAt(index);
    });
  }

  void calculate() {
    double totalCredits = 0;
    double weightedSum = 0;

    for (var sub in subjects) {
      double? credit = double.tryParse(sub['credit']!.text);
      double? grade = double.tryParse(sub['grade']!.text);

      if (credit != null && grade != null) {
        weightedSum += grade * credit;
        totalCredits += credit;
      }
    }

    String result = totalCredits > 0
        ? 'Total Score : ${(weightedSum / totalCredits).toStringAsFixed(2)}%'
        : "Fill in the blanks";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Result'),
        content: Text(result,style: TextStyle(fontSize: 18),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Developer'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name : HackerManTeam'),
                          Text('GitHub : '),
                          Text('https://github.com/hackermanteamofficial')
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  ),
                  child: const Text('About Developer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size.square(45),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Subject field
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: subjects[index]["name"],
                                decoration: const InputDecoration(
                                  labelText: "Subject",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Credit field
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: subjects[index]["credit"],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Credit",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Grade field
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: subjects[index]["grade"],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Grade",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Remove button
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => removeSubject(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: addSubject,
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.teal,foregroundColor: Colors.white),
                      child: const Text("Add Subject"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: calculate,
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, foregroundColor: Colors.white),
                      child: const Text("Calculate"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
