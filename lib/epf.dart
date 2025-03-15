import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class EPF extends StatefulWidget {
  const EPF({super.key});

  @override
  State<EPF> createState() => _EPFState();
}

class _EPFState extends State<EPF> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  List<FlSpot> epfData = [];
  List<FlSpot> noEpfData = [];

  Future<void> calculateAndPlotEPF() async {
    double income = double.tryParse(_incomeController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/calculate_epf'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'income': income, 'years': years, 'rate': rate}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          epfData = List<FlSpot>.generate(years, (index) => FlSpot(index + 1, data['withEPF'][index]));
          noEpfData = List<FlSpot>.generate(years, (index) => FlSpot(index + 1, data['withoutEPF'][index]));
        });
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EPF Calculation"),
        backgroundColor: const Color.fromARGB(255, 85, 158, 187),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Employee Income',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Years until Retirement',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'EPF Rate (%)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateAndPlotEPF,
              child: const Text("Calculate EPF"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(spots: epfData, isCurved: true, color: Colors.green),
                    LineChartBarData(spots: noEpfData, isCurved: true, color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _yearsController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}
