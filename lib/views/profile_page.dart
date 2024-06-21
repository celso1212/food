import 'package:flutter/material.dart';
import 'package:food/components/my_input.dart';
import 'package:food/services/firebase.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usuarioController = TextEditingController();
    TextEditingController telefoneController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Editar usuário',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                MyInput(
                    hintText: 'Nome de usuário',
                    textEditingController: usuarioController),
                MyInput(
                    hintText: 'Telefone',
                    textEditingController: telefoneController),
                MyInput(
                    hintText: 'Endereço',
                    textEditingController: enderecoController),
                OutlinedButton(
                    onPressed: () async {
                      var response = await atualizarUsuario({
                        'usuario': usuarioController.text,
                        'telefone': telefoneController.text,
                        'endereco': enderecoController.text,
                      });

                      if (response == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Usuário atualizado!'),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Ocorreu um erro'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text('Salvar'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
