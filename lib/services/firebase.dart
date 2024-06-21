import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food/firebase_options.dart';

criarUsuarioAuth(email, senha) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha);
  } catch (e) {
    return false;
  }
}

autenticarUsuario(email, senha) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha);

    return true;
  } catch (e) {
    return false;
  }
}

criarUsuario(id, dadosRegistro) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var db = FirebaseFirestore.instance;

  try {
    await db.collection('users').doc(id).set({
      'usuario': dadosRegistro['usuario'],
      'telefone': dadosRegistro['telefone'],
      'endereco': dadosRegistro['endereco'],
      'favoritos': [],
      'carrinho': []
    });
    return true;
  } catch (e) {
    print(e);
    return e;
  }
}

pegarUsuario() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  try {
    var response = await db.collection('users').doc(usuarioLogado?.uid).get();

    return response.data();
  } catch (e) {
    return e;
  }
}

adicionarAosFavoritos(produto) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  
  try {
    await db.collection('users').doc(usuarioLogado?.uid).update({
      'favoritos': FieldValue.arrayUnion([produto])
    });

    return true;
  } catch (e) {
    return false;
  }
}

realizarCompra(carrinho, total) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  try {
    await db.collection('Orders').add({
      'usuario': usuarioLogado?.uid,
      'carrinho': FieldValue.arrayUnion(carrinho),
      'total': total,
    });

    await db.collection('users').doc(usuarioLogado?.uid).update({
      'carrinho': []
    });

    return true;
  } catch (e) {
    return e;
  }
}

pegarBanner() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var storage = FirebaseStorage.instance;

  try {
    Reference ref = storage.ref().child('assets');

    var imagens = await ref.list();

    var banner =
        imagens.items.where((e) => e.fullPath == 'assets/banner.png').first;
    var bannerUrl = await banner.getDownloadURL();

    return bannerUrl;
  } catch (e) {
    return e;
  }
}

pegarCategorias() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;

  try {
    var result = await db.collection('Categories').get();
    var categorias = result.docs.map((c) => c.data()).toList();
    print(categorias);

    return categorias;
  } catch (e) {
    return e;
  }
}

pegarProdutos() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;

  try {
    var result = await db.collection('Foods').get();
    var comidas = result.docs.map((c) => c.data()).toList();

    return comidas;
  } catch (e) {
    return e;
  }
}

adicionarProdutoAoCarrinho(produto) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  try {
    await db.collection('users').doc(usuarioLogado?.uid).update({
      'carrinho': FieldValue.arrayUnion([produto])
    });
    return true;
  } catch (e) {
    return e;
  }
}

adicionarFeedback(feedback) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  try {
    var usuarioFirestore =
        await db.collection('users').doc(usuarioLogado?.uid).get();

    await db.collection('Feedbacks').add({
      'feedback': feedback,
      'usuario': {'id': usuarioLogado?.uid, 'dados': usuarioFirestore.data()},
    });

    return true;
  } catch (e) {
    return e;
  }
}

atualizarUsuario(dadosUsuario) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var usuarioLogado = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  try {
    await db.collection('users').doc(usuarioLogado?.uid).update({
      'usuario': dadosUsuario['usuario'],
      'telefone': dadosUsuario['telefone'],
      'endereco': dadosUsuario['endereco'],
    });

    return true;
  } catch (e) {
    return e;
  }
}
