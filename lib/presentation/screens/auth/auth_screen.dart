import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      hintText: "email@email.com",
                      hintFadeDuration: Duration(milliseconds: 300),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      hintText: "*******",
                      hintFadeDuration: Duration(milliseconds: 300),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FilledButton(
            onPressed: () async {
              print({
                'email': emailController.text,
                'password': passwordController.text
              });

            },
            child: const Text("L O G I N"),
          ),
        ],
      ),
    );

    
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
