import 'package:flutter/material.dart';
import 'package:task_manager/config/network/post/post_model.dart';
import 'package:task_manager/config/network/post/post_network_request.dart';
import 'package:task_manager/home_page.dart';

class TaskAdder extends StatefulWidget {
  @override
  _TaskAdderState createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  // Controllers to retrieve the input from the text field
  final TextEditingController _taskNameController = TextEditingController();
  bool _taskCompleted = false; // To store the task status (true for completed, false for not completed)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Name TextField
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide:BorderSide(
                    color: Colors.black,
                  )
                ),
              ),

            ),
            SizedBox(height: 20),

            // Task Status Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Completed?',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _taskCompleted,
                  onChanged: (value) {
                    setState(() {
                      _taskCompleted = value;
                    });
                  },
                  activeColor: Colors.black,
                  inactiveThumbColor: Colors.black12,
                  inactiveTrackColor: Colors.black45,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Add Task Button
            Center(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Colors.black,
                      Colors.black12],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(


                  onPressed: () {
                    // Here, you can handle the submit action
                    String taskName = _taskNameController.text;
                    bool taskCompleted = _taskCompleted;

                    print('Task Name: $taskName');
                    print('Task Completed: $taskCompleted');

                    if (taskName.isNotEmpty) {
                      PostNetworkRequest().postModel(taskName,taskCompleted).toString();
                      _showSnackbar('Task created');
                      Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context)=>homePage()
                          )
                      );
                    }
                    else{
                      _showSnackbar('Task cannot be empty');
                    }


                    // You can also navigate back or handle the task addition
                    // Navigator.pop(context);
                  },



                  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );

  }
  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message,textAlign: TextAlign.center,),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}






