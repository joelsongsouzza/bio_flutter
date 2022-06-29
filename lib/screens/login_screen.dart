import 'package:biomob/components/loading_container.dart';
import 'package:biomob/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoadingRequest = false;
  void setLoadingRequestTo(bool newValue) => setState(() => isLoadingRequest = newValue);

  String? message;
  void setMessageTo(String? newValue) => setState(() => message = newValue);

  Future<void> sendSignInRequest() async {
    setLoadingRequestTo(true);
    setMessageTo(null);

    FocusScope.of(context).unfocus();

    String email = emailController.text;
    String password = passwordController.text;
    Map<String, dynamic> signInResult = await signIn(email, password);

    setLoadingRequestTo(false);

    print(signInResult);
    bool status = signInResult['status'];
    String message = signInResult['message'];

    if (status) {
      setMessageTo("Login realizado com sucesso!");
    } else if (!status && message == "need-activate") {
      setMessageTo("Favor, valide sua conta no seu email!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: Navigator.of(context).pop,
        child: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  TextField(
                    autocorrect: false,
                    controller: emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    autocorrect: false,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Senha"),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      await sendSignInRequest();
                    },
                    child: const Text("Entrar"),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    child: message != null
                        ? Text(
                            message!,
                            style: TextStyle(fontSize: 16),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
          if (isLoadingRequest) const LoadingContainer(),
        ],
      ),
    );
  }
}
