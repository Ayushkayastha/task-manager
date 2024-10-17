import 'package:flutter/material.dart';
import 'package:task_manager/config/network/delete/delete_network_request.dart';
import 'package:task_manager/config/network/get_all/get_all_model.dart';
import 'package:task_manager/config/network/get_all/get_network_request.dart';
import 'package:task_manager/task_adder.dart';
import 'package:task_manager/task_editer.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Future<List<GetAllModel>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = GetNetworkRequest().getAllModel(); // Initialize the tasks data
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasksFuture = GetNetworkRequest().getAllModel(); // Refresh tasks by re-fetching the data
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Stack(
        children: [
          FutureBuilder<List<GetAllModel>>(
            future: _tasksFuture,
            builder: (context, snapshot) {
              // Display a loading spinner while waiting for the data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Display error message if an error occurred
              else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }

              // If data is successfully fetched
              else if (snapshot.hasData) {
                var tasks = snapshot.data;

                // Check if the result is null or empty
                if (tasks == null || tasks.isEmpty) {
                  return const Center(child: Text('No tasks available.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: tasks.length, // Adjust this depending on your API response structure
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.name ?? 'No name',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Completed: ${task.completed}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Task ID: ${task.id ?? 'No ID'}',
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: ()=>{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder:
                                      (context)=>TaskEditer(
                                        name: task.name ??'',
                                        completed: task.completed ?? false,
                                        id:task.id??'',                                        ),
                                      )
                                  )
                                },
                                    icon: Icon(Icons.edit)
                                ),
                                IconButton(
                                    onPressed: ()=>{_confirmDelete(task.id??'No id')},
                                    icon: Icon(Icons.delete)
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              // Default fallback if no data
              return const Center(child: Text('No tasks found.'));
            },
          ),

          Align(
            alignment: Alignment.bottomRight, // Align to bottom-right corner
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add some padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end, // Aligns content to right inside the column
                children: [
                  IconButton(
                    icon: Icon(Icons.add), // This is the + icon
                    onPressed: () {
                      print("Add button pressed");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>TaskAdder())
                      );
                    },
                    color: Colors.blue, // Optional: Set the icon color
                    iconSize: 42.0,
                    // Optional: Set the icon size
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Future<void> _confirmDelete(String taskId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without deleting
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Call your delete API here
                print('detete start');
                bool success = await DeleteNetworkRequest().deteleModel(taskId);
                print('detete end');
                if (success) {
                  // Show a snackbar or any indication of success
                  _refreshTasks();
                  _showSnackbar('Task deleted successfully.');

                } else {
                  _showSnackbar('Failed to delete task.');
                }
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
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
