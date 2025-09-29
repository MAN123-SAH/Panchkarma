// lib/pages/role/role_dashboard_page.dart

import 'package:flutter/material.dart';

class RoleDashboardPage extends StatelessWidget {
  final String role;
  const RoleDashboardPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$role Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: _buildDashboardContent(),
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    switch (role.toLowerCase()) {
      case 'patient':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.person, size: 80, color: Colors.blueGrey),
            SizedBox(height: 20),
            Text('Welcome, Patient!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('View your reports, appointments, and more.'),
          ],
        );
      case 'doctor':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.medical_services, size: 80, color: Colors.teal),
            SizedBox(height: 20),
            Text('Welcome, Doctor!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Manage patients, check reports, and schedule appointments.'),
          ],
        );
      case 'clinic':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_hospital, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text('Welcome, Clinic!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Manage doctors, patients, and clinic schedules.'),
          ],
        );
      default:
        return const Text('Unknown role');
    }
  }
}