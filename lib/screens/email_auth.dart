import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class EmailAuth extends StatefulWidget {
  final Function returnAnimation;
  EmailAuth(this.returnAnimation);
  @override
  _EmailAuthState createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  var _isLogin = true;
  var _isWaiting = false;
  String _email;
  String _password;
  String _message;

  SnackBar _errorSnackBar(String errorMessage) {
    return SnackBar(
      content: Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Email Authentification')),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Card(
            elevation: 12,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (String email) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email)) {
                              return 'Please provide a valid email adress';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _email = newValue,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            icon: const Icon(Icons.email),
                            labelText: 'Email',
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (String password) {
                            _password = password;
                            if (password.length < 6) {
                              return 'Please provide a longer password';
                            }
                            return null;
                          },
                          onSaved: (String newValue) => _password = newValue,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            icon: const Icon(Icons.lock),
                            labelText: 'Password',
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Builder(
                          builder: (ctx) => RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            onPressed: _isWaiting? null: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _isWaiting = true;
                                });
                                if (_isLogin) {
                                  _message = await context
                                      .read<Auth>()
                                      .signInWithEmail(_email, _password);
                                } else {
                                  _message = await context
                                      .read<Auth>()
                                      .signUpWithEmail(_email, _password);
                                }
                                if (_message == 'success') {
                                  widget.returnAnimation();
                                } else {
                                  Scaffold.of(ctx).hideCurrentSnackBar();
                                  Scaffold.of(ctx)
                                      .showSnackBar(_errorSnackBar(_message));
                                }
                                setState(() {
                                  _isWaiting = false;
                                });
                              }
                            },
                            child: !_isWaiting
                                ? Text(
                                    !_isLogin ? 'Sign Up' : 'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                : const CircularProgressIndicator(
                                    // valueColor: AlwaysStoppedAnimation<Color>(
                                    //     Colors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? 'Sign Up Instead' : 'Login Instead',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.75)),
                          ),
                        ),
                        const SizedBox(height: 3),
                      ],
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
