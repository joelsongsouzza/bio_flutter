import 'package:biomob/components/loading_container.dart';
import 'package:biomob/controllers/register_controller.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  bool isLoadingRequest = false;
  void setLoadingRequestTo(bool newValue) => setState(() => isLoadingRequest = newValue);

  String? errorMessage;
  void setErrorMessageTo(String? newValue) => setState(() => errorMessage = newValue);

  bool accountCreated = false;
  void setAccountCreatedTo(bool newValue) => setState(() => accountCreated = newValue);

  Future<void> validateFieldsAndSendRequest() async {
    setAccountCreatedTo(false);
    setErrorMessageTo(null);

    FocusScope.of(context).unfocus();

    String email = emailController.text;
    String password = passwordController.text;
    String cpf = cpfController.text;

    bool inputsAreValid = validaInputs(email, password);

    if (inputsAreValid) {
      setLoadingRequestTo(true);
      final accountCreationResponse = await sendAccountCreationRequest(email, password, cpf);
      setLoadingRequestTo(false);

      bool status = accountCreationResponse['status'];
      String message = accountCreationResponse['message'];

      if (!status && message == 'duplicate') {
        setErrorMessageTo('CPF já existe');
      } else if (status) {
        setAccountCreatedTo(true);
      }
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
                children: [
                  Spacer(),
                  TextField(
                    autocorrect: false,
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    autocorrect: false,
                    controller: cpfController,
                    decoration: InputDecoration(hintText: "CPF"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    autocorrect: false,
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Senha"),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      await validateFieldsAndSendRequest();
                    },
                    child: Text("Cadastrar"),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: errorMessage != null
                        ? Text(
                            errorMessage!,
                            style: TextStyle(fontSize: 16),
                          )
                        : null,
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    child: accountCreated
                        ? Text(
                            "Conta criada com sucesso!",
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
