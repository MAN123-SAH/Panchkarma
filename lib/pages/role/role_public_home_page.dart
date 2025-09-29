// lib/pages/role/role_public_home_page.dart

import 'package:flutter/material.dart';
// Corrected Import Path
import '../auth/login_page.dart'; 


class RolePublicHomePage extends StatelessWidget {
  final String role;
  const RolePublicHomePage({super.key, required this.role});

  // --- NEW: Role-Specific Review Data ---
  List<Map<String, dynamic>> _getReviewsForRole(String role) {
    switch (role.toLowerCase()) {
      case 'patient':
        return [
          {'review': 'The booking process was seamless, and the Ayurvedic consultation was insightful.', 'author': 'Anil K.', 'color': Colors.teal.shade100},
          {'review': 'I felt truly cared for. My personalized treatment plan has made a huge difference.', 'author': 'Priya S.', 'color': Colors.blue.shade100},
          {'review': 'Easy access to my reports and timely reminders for follow-up appointments.', 'author': 'Rahul M.', 'color': Colors.teal.shade100},
        ];
      case 'doctor':
        return [
          {'review': 'The system streamlines patient record management, freeing up time for care.', 'author': 'Dr. Sharma', 'color': Colors.green.shade100},
          {'review': 'Excellent platform for collaborative diagnosis and sharing research updates.', 'author': 'Dr. Gupta', 'color': Colors.teal.shade100},
          {'review': 'Joining the network was simple. I appreciate the professional development resources.', 'author': 'Dr. Varma', 'color': Colors.green.shade100},
        ];
      case 'clinic':
        return [
          {'review': 'The clinic management tools drastically improved scheduling efficiency and billing.', 'author': 'Nandi Clinic Admin', 'color': Colors.purple.shade100},
          {'review': 'Our patient satisfaction scores increased thanks to the seamless digital experience.', 'author': 'Wellness Center Mgmt', 'color': Colors.teal.shade100},
          {'review': 'Fantastic support for integrating new AyurSutra services into our existing setup.', 'author': 'AyurCare Hospital', 'color': Colors.purple.shade100},
        ];
      default:
        return [{'review': 'No specific reviews available for this role.', 'author': 'System', 'color': Colors.grey.shade100}];
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviews = _getReviewsForRole(role);

    return Scaffold(
      appBar: AppBar(
        title: Text('$role Overview'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAuthButtons(context),
              const SizedBox(height: 30),

              // 2. Reviews Section
              Text(
                'Trusted Reviews from ${role}s',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
              ),
              const Divider(thickness: 2, color: Colors.teal),
              
              // Map the role-specific reviews to cards
              ...reviews.map((reviewData) => _buildReviewCard(
                reviewData['review'], 
                reviewData['author'], 
                reviewData['color']
              )),

              const SizedBox(height: 40),
              _buildRoleInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Ready to proceed as a $role?',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _navigateToLoginPage(context, isSignUp: false),
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _navigateToLoginPage(context, isSignUp: true),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Sign Up'),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.teal, side: const BorderSide(color: Colors.teal)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _navigateToLoginPage(BuildContext context, {required bool isSignUp}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleLoginPage(selectedRole: role, startInSignUpMode: isSignUp),
      ),
    );
  }

  Widget _buildReviewCard(String review, String author, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: color,
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.orange),
        title: Text(review),
        subtitle: Text('— $author'),
      ),
    );
  }

  Widget _buildRoleInfo() {
    String info = '';
    switch (role.toLowerCase()) {
      case 'patient': info = 'View our health guides and appointment booking process.'; break;
      case 'doctor': info = 'Information on joining our network and professional resources.'; break;
      case 'clinic': info = 'Learn about our services for clinic management and optimization.'; break;
    }
    return Text(info, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600));
  }
}