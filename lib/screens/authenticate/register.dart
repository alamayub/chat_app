import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../widgets/form_input.dart';
import '../../widgets/submit_buttons.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool? _loading;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  register() async {
    if(_username.text.isNotEmpty && _name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() => _loading = true);
      bool res = await AuthService().register(_email.text.trim(), _name.text.trim(), _email.text.trim(), _password.text.trim());
      if(res == false) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading == true ? Center(child: CircularProgressIndicator()) : Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextFormInputField(controller: _username, hint: 'john', prefixIcon: Icon(Icons.person_outline)),
            const SizedBox(height: 12),
            TextFormInputField(controller: _name, hint: 'John Doe', prefixIcon: Icon(Icons.person_outline)),
            const SizedBox(height: 12),
            TextFormInputField(controller: _email, hint: 'someone@mail.com', prefixIcon: Icon(Icons.email_outlined)),
            const SizedBox(height: 12),
            TextFormInputField(controller: _password, hint: '******', obscure: true, prefixIcon: Icon(Icons.lock_outline)),
            const SizedBox(height: 12),
            roundedSubmitButtonWithText('Register', register),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Already have an account? ', style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () => widget.toggleView(),
                  child: Text('Login', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500, letterSpacing: .5),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
