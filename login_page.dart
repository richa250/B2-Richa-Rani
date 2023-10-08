import 'package:flutter/material.dart';
import 'package:image_app/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _emailErrorText = "";
  String _passwordErrorText = "";

  void _validateInputs() {
    setState(() {
      _emailErrorText = "";
      _passwordErrorText = "";

      if (_emailController.text.isEmpty) {
        _emailErrorText = 'Please enter your email.';
      } else if (!_isValidEmail(_emailController.text)) {
        _emailErrorText = 'Please enter a valid email.';
      }

      if (_passwordController.text.isEmpty) {
        _passwordErrorText = 'Please enter your password.';
      }
    });

    if (_formKey.currentState!.validate()) {
    
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      // Redirect to the home page on successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
  
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailErrorText,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your email.';
                  } else if (!_isValidEmail(value!)) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                ),
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _validateInputs,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
