// lib/pages/role/role_selection_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
// ⭐ CORRECT IMPORT: Same folder
import 'role_public_home_page.dart'; 


class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  Widget _buildHeaderLogo() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.spa, size: 48, color: Colors.teal.shade800),
            const SizedBox(height: 8),
            const Text(
              "AyurSutra Wellness",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Holistic Health Dashboard",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
      BuildContext context, String role, IconData icon, MaterialColor color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: InkWell(
            onTap: () {
              // Navigate to the Public Home Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RolePublicHomePage(role: role),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color.shade600, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    role,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent, 
        elevation: 0,
        // SystemUiOverlayStyle is available due to flutter/services.dart import
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
      ),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderLogo(),
                  const SizedBox(height: 40),
                  const Text(
                    "Choose your role:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.teal),
                  ),
                  const SizedBox(height: 20),

                  // Horizontal Roles Layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRoleCard(context, "Patient", Icons.person, Colors.blueGrey),
                      _buildRoleCard(context, "Doctor", Icons.medical_services, Colors.teal),
                      _buildRoleCard(context, "Clinic", Icons.local_hospital, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}