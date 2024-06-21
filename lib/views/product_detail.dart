import 'package:flutter/material.dart';
import 'package:food/services/firebase.dart';

class ProductDetail extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var produto;

  ProductDetail({super.key, required this.produto});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Produto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.produto['url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.produto['nome'],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                widget.produto['lanchonete'],
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'R\$ ${widget.produto['preco']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Descrição',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.produto['descricao'],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  var response =
                      await adicionarProdutoAoCarrinho(widget.produto);
                  if (response == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Adicionado ao carrinho!'),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ocorreu um erro'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text('Adicionar ao carrinho'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  var response = await adicionarAosFavoritos(widget.produto);
                  if (response == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Adicionado aos favoritos!'),
                      backgroundColor: Colors.green,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ocorreu um erro'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text('Adicionar aos favoritos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
