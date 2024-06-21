import 'package:flutter/material.dart';
import 'package:food/services/firebase.dart';
import 'package:food/views/navigation.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var totalCompra = 0;
  var carrinho = [];
  Future? carrinhoFuture;

  void calcularTotalCompra(carrinho) {
    var total = 0;
    for (var produto in carrinho) {
      total += (produto['preco'] as int);
    }

    setState(() {
      totalCompra = total;
    });
  }

  void pegarCarrinho(carrinho) {
    setState(() {
      this.carrinho = carrinho;
    });
  }

  @override
  void initState() {
    super.initState();
    carrinhoFuture = pegarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        future: carrinhoFuture,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var carrinho = snapshot.data['carrinho'];

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              calcularTotalCompra(carrinho);
                              pegarCarrinho(carrinho);
                            });

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                          childAspectRatio: 0.75),
                                  itemCount: carrinho.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      elevation: 4.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16.0)),
                                            child: Image.network(
                                              carrinho[index]['url'],
                                              height: 120.0,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:
                                                Text(carrinho[index]['nome']),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.0,
                                                bottom: 2.0,
                                                left: 8.0),
                                            child: Text(
                                              carrinho[index]['lanchonete'],
                                              style: TextStyle(
                                                  color: Colors.black38),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'R\$ ${carrinho[index]['preco']}',
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
                        }))),
            Divider(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Total: $totalCompra'),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  var response = await realizarCompra(carrinho, totalCompra);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Navigation()));

                  if (response == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Compra realizada!'),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ocorreu um erro'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Comprar'),
              ),
            )
          ],
        ));
  }
}
