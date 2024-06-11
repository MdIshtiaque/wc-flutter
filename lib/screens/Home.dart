import 'package:flutter/material.dart';
import 'package:sarra/models/user.dart';

import '../widgets/add_data_dialog.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCounters(),
                    const SizedBox(height: 70),
                    _buildButtons(context),
                  ],
                ),
              ),
            ),
            _buildUserInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCounters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCounter('Inventory', 120),
        _buildCounter('Activity', 50),
        _buildCounter('Offline', 30),
      ],
    );
  }

  Widget _buildCounter(String title, int count) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildButton(context, 'Add Data', Icons.add, Colors.blue, () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddDataDialog(),
          );
        }),
        const SizedBox(height: 10),
        _buildButton(context, 'Sync Data', Icons.sync, Colors.green, () {
          // Handle Sync Data action
        }),
        const SizedBox(height: 10),
        _buildButton(context, 'My List', Icons.list, Colors.orange, () {
          // Handle Sync Data action
        }),
        const SizedBox(height: 10),
        _buildButton(context, 'Logout', Icons.logout, Colors.red, () {
          // Handle Sync Data action
        }),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 16),
        minimumSize: const Size(double.infinity, 50), // Ensure buttons are the same size
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to profile screen
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user))); // Update with your profile screen
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logged in as: ${user.fullname}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
