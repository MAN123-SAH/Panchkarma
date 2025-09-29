// lib/pages/auth/login_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
// ⭐ CORRECT IMPORT: Go up one level (..), then into 'role'
import '../role/role_dashboard_page.dart'; 
import '../../providers/auth_provider.dart'; 

class RoleLoginPage extends StatefulWidget { 
  final String selectedRole;
  final bool startInSignUpMode; 
  
  const RoleLoginPage({
    super.key, 
    required this.selectedRole,
    this.startInSignUpMode = false,
  }); 

  @override
  State<RoleLoginPage> createState() => _RoleLoginPageState();
}

class _RoleLoginPageState extends State<RoleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  
  late bool _isLoginMode; 

  @override
  void initState() {
    super.initState();
    // Set the initial mode based on the parameter passed
    _isLoginMode = !widget.startInSignUpMode; 
  }

  // --- Form Submission Logic ---
  void _submitAuthForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = false;

    if (_isLoginMode) {
      // 1. LOGIN
      success = await authProvider.login(
        email: _email,
        password: _password,
        role: widget.selectedRole,
      );
      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RoleDashboardPage(role: widget.selectedRole),
          ),
        );
      }
    } else {
      // 2. SIGN UP
      success = await authProvider.signup(
        email: _email,
        password: _password,
        role: widget.selectedRole,
      );
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.signupMessage ?? 'Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _isLoginMode = true; // Switch to Login after successful signup
        });
      }
    }

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'An unknown error occurred.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context); 
    final bool isLoading = authProvider.isLoading; 
    
    final String currentAction = _isLoginMode ? 'Login' : 'Sign Up';

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedRole} $currentAction'), 
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Header Icon
                  Icon(
                    widget.selectedRole == 'Patient' ? Icons.person : 
                    widget.selectedRole == 'Doctor' ? Icons.medical_services : 
                    Icons.local_hospital, 
                    size: 80, 
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    '$currentAction for ${widget.selectedRole}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 30.0),

                  // Email Input
                  TextFormField(
                    key: const ValueKey('email'),
                    decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => (value == null || !value.contains('@')) ? 'Please enter a valid email.' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  const SizedBox(height: 15.0),

                  // Password Input
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      _password = value;
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  
                  // Confirm Password for Sign Up
                  if (!_isLoginMode) ...[
                    const SizedBox(height: 15.0),
                    TextFormField(
                      key: const ValueKey('confirm_password'),
                      decoration: const InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock_reset)),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value != _password) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                      onSaved: (value) => _confirmPassword = value!,
                    ),
                  ],

                  const SizedBox(height: 30.0),

                  // Submit Button
                  ElevatedButton(
                    onPressed: isLoading ? null : _submitAuthForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, 
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: isLoading 
                        ? const SizedBox(
                            height: 20, width: 20, 
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            currentAction,
                            style: const TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                  ),
                  
                  const SizedBox(height: 15.0),

                  // Toggle Button
                  TextButton(
                    onPressed: () {
                      if (!isLoading) {
                        setState(() {
                          _isLoginMode = !_isLoginMode;
                          _formKey.currentState?.reset(); 
                        });
                      }
                    },
                    child: Text(
                      _isLoginMode 
                        ? 'Don\'t have an account? Sign up'
                        : 'Already have an account? Log In',
                      style: const TextStyle(color: Colors.teal),
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
}