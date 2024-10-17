import 'package:flutter/material.dart';
import 'package:task_manager/home_page.dart';

import 'config/network/update/update_network_request.dart';

class TaskEditer extends StatefulWidget {
  final String name;
  final bool completed;
  final String id;
  const TaskEditer({Key? key,required this.name,required this.completed,required this.id}): super(key: key);

  @override
  State<TaskEditer> createState() => _TaskEditerState();
}

class _TaskEditerState extends State<TaskEditer> {
  late TextEditingController _taskController;
  late bool _taskCompleted ; // To store the task status (true for completed, false for not completed)


  @override
  void initState() {
    super.initState();
    // Initialize the controller inside initState with the widget's name
    _taskController = TextEditingController(text: widget.name);
    _taskCompleted = widget.completed;
  }

  @override
  void dispose() {
    // Dispose of the controller when done
    _taskController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit task'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(
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
                    String taskName = _taskController.text;
                    bool taskCompleted = _taskCompleted;

                    print('Task Name: $taskName');
                    print('Task Completed: $taskCompleted');

                    if (taskName.isNotEmpty) {
                      UpdateNetworkRequest().updateModel(widget.id,taskName,taskCompleted);
                      _showSnackbar('Task updated');
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
                    'Update Task',
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
