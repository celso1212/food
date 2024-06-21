import 'package:flutter/material.dart';
import 'package:food/services/firebase.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: pegarUsuario(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var favoritos = snapshot.data['favoritos'];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.75),
                        itemCount: favoritos.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            elevation: 4.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0)),
                                  child: Image.network(
                                    favoritos[index]['url'],
                                    height: 120.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(favoritos[index]['nome']),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.0, bottom: 2.0, left: 8.0),
                                  child: Text(
                                    favoritos[index]['lanchonete'],
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'R\$ ${favoritos[index]['preco']}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }
              })),
    );
  }
}
