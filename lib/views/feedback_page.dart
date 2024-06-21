import 'package:flutter/material.dart';
import 'package:food/components/my_input.dart';
import 'package:food/services/firebase.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                MyInput(
                    hintText: 'Feedback',
                    textEditingController: feedbackController),
                OutlinedButton(
                    onPressed: () async {
                      var response =
                          await adicionarFeedback(feedbackController.text);
                      if (response == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Feedback enviado!'),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Ocorreu um erro'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text('Enviar'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
