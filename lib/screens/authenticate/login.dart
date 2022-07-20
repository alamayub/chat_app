import 'package:chat_app/widgets/form_input.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../widgets/submit_buttons.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key? key, required this.toggleView}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool? _loading;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  login() async {
    if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
      setState(() => _loading = true);
      bool res = await AuthService().login(_email.text.trim(), _password.text.trim());
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
            Text('WELCOME BACK!', style: TextStyle(letterSpacing: .5, fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 30),
            TextFormInputField(controller: _email, hint: 'someone@mail.com', prefixIcon: Icon(Icons.email_outlined)),
            const SizedBox(height: 12),
            TextFormInputField(controller: _password, hint: '******', obscure: true, prefixIcon: Icon(Icons.lock_outline)),
            const SizedBox(height: 12),
            roundedSubmitButtonWithText('Login', login),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ', style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () => widget.toggleView(),
                  child: Text('Register', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500, letterSpacing: .5),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
