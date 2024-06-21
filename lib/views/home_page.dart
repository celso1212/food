import 'package:flutter/material.dart';
import 'package:food/services/firebase.dart';
import 'package:food/views/product_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget banner(BuildContext context) {
    return FutureBuilder(
        future: pegarBanner(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var banner = snapshot.data;
            return Center(
              child: Image.network(banner),
            );
          }
        });
  }

  Widget categorias(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'Categorias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder(
            future: pegarCategorias(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var categorias = snapshot.data;

                return Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var categoria in categorias)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        categoria['url'],
                                        height: 100,
                                      ),
                                      Text(categoria['nome'])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  Widget populares(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Text(
            'Populares',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder(
            future: pegarProdutos(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var comidas = snapshot.data;

                return Container(
                  margin: EdgeInsets.only(left: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var comida in comidas)
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(1),
                                  offset: Offset(0, 1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0)
                            ]),
                            margin: EdgeInsets.only(right: 10.0),
                            height: 200,
                            width: 150,
                            child: Card(
                              borderOnForeground: true,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              produto: comida,
                                            ))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      comida['url'],
                                      height: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      comida['nome'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      comida['lanchonete'],
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                    Text('R\$ ${comida["preco"]}')
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            banner(context),
            categorias(context),
            populares(context),
          ],
        ),
      ),
    );
  }
}
