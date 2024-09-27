import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart package

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image; // Store selected image
  String _userName = "Adeel Arif";
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    db.loadData(); // Load tasks from the database
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Avatar
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // User Name
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Charts for Task Statistics
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Task Statistics',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTaskStatisticsChart(),
                  const SizedBox(height: 20),

                  // Task Grid View
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Completed Tasks Grid
                      _buildTaskGrid('Completed Tasks', true),
                      const SizedBox(width: 10),

                      // Pending Tasks Grid
                      _buildTaskGrid('Pending Tasks', false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the statistics chart for completed and pending tasks using fl_chart
  Widget _buildTaskStatisticsChart() {
    int completedCount = db.toDoList.where((task) => task[1] == true).length;
    int pendingCount = db.toDoList.where((task) => task[1] == false).length;

    return SizedBox(
      height: 150,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: completedCount.toDouble(),
                  color: Colors.green,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: pendingCount.toDouble(),
                  color: Colors.red,
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Completed');
                    case 1:
                      return const Text('Pending');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  // Builds a grid view for completed or pending tasks
  Widget _buildTaskGrid(String title, bool isCompleted) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isCompleted ? Colors.green.shade100 : Colors.red.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount:
                    db.toDoList.where((task) => task[1] == isCompleted).length,
                itemBuilder: (context, index) {
                  final task = db.toDoList
                      .where((task) => task[1] == isCompleted)
                      .toList()[index];
                  return Card(
                    child: Center(
                      child: Text(task[0]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model for task data
class TaskData {
  final String taskStatus;
  final int taskCount;

  TaskData(this.taskStatus, this.taskCount);
}
