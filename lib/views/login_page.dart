import 'package:flutter/material.dart';
import 'package:food/components/my_input.dart';
import 'package:food/services/firebase.dart';
import 'package:food/views/navigation.dart';
import 'package:food/views/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 70,
            ),
            SizedBox(height: 20),
            MyInput(
              hintText: 'Email',
              textEditingController: emailController,
            ),
            SizedBox(height: 10),
            MyInput(
              hintText: 'Senha',
              obscureText: true,
              textEditingController: passwordController,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                OutlinedButton(
                    onPressed: () {
                      var auth = autenticarUsuario(
                          emailController.text, passwordController.text);

                      if (auth == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Credenciais inválidas'),
                          backgroundColor: Colors.red,
                        ));

                        return;
                      }

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Navigation()));
                    },
                    child: Text('Entrar')),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage())),
                    child: Text('Criar conta')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
