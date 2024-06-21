import 'package:flutter/material.dart';
import 'package:food/components/my_input.dart';
import 'package:food/services/firebase.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usuarioController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController telefoneController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();
    TextEditingController senhaController = TextEditingController();
    TextEditingController confirmaSenhaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(
            size: 70,
          ),
          MyInput(
              hintText: 'Nome de usuário',
              textEditingController: usuarioController),
          MyInput(hintText: 'Email', textEditingController: emailController),
          MyInput(
              hintText: 'Telefone', textEditingController: telefoneController),
          MyInput(
              hintText: 'Endereço', textEditingController: enderecoController),
          MyInput(
              hintText: 'Senha',
              obscureText: true,
              textEditingController: senhaController),
          MyInput(
              hintText: 'Confirmar Senha',
              obscureText: true,
              textEditingController: confirmaSenhaController),
          ElevatedButton(
              onPressed: () async {
                if (senhaController.text.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'A senha deve ser maior que 8 caracteres',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.yellow));
                  return;
                }
                if (senhaController.text != confirmaSenhaController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Senha não igual',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.yellow));
                  return;
                }

                var authResponse = await criarUsuarioAuth(
                    emailController.text, senhaController.text);
                var firestoreResponse =
                    await criarUsuario(authResponse.user.uid, {
                  'usuario': usuarioController.text,
                  'telefone': telefoneController.text,
                  'endereco': enderecoController.text,
                });

                usuarioController.text = '';
                emailController.text = '';
                telefoneController.text = '';
                enderecoController.text = '';
                senhaController.text = '';
                confirmaSenhaController.text = '';

                if (firestoreResponse != true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Ocorreu um erro $firestoreResponse'),
                    backgroundColor: Colors.red,
                  ));

                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Conta criada com sucesso!'),
                  backgroundColor: Colors.green,
                ));

                Navigator.pop(context);
              },
              child: Text('Criar conta')),
        ],
      ),
    );
  }
}
