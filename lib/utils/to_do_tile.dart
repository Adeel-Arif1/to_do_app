import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0), // Consistent padding
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), // Added const
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white, // Set background to white for better contrast
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Light shadow for depth
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.deepPurpleAccent, // Deep purple accent
                checkColor: Colors.white, // White check mark for contrast
              ),

              // Task name
              Expanded(
                // Ensures task name doesn't overflow
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500, // Slightly bolder for readability
                    color: taskCompleted ? Colors.grey : Colors.black, // Color changes based on completion
                    decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents overflow issues
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
