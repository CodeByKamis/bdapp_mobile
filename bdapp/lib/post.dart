//cria automatico colocando st
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //aqui fica a sua logica

//variavel que observa o qu eo usuario digita o famoso fofoqueiro
  TextEditingController novatemperatura = TextEditingController();

  @override
  void initState(){
    super.initState();
    mensagem = "";
    erro = "";
  }


  String? erro = ""; //variavel para armazenar algum erro caso ocorra
  String? mensagem = ""; //para alertar que deu certo
//get o dado está no banco e sai para ir à aplicação, tem um wait ai
//post o dado está a aplicação e sai de la e é enviado para o banco, ele é future pois no FUTURO o dado vai dar a confirmação à aoplicação que deu certo
//funcao post
  Future<void> postValue() async{ //async porque espera a confirmação do futuro
  //crio uma instancia do banco, na coleção monitoramento e adciono algo
    try{
      FirebaseFirestore.instance.collection("monitoramento").add(
        {
          "temperatura": novatemperatura.text,
        }
      );
      setState(() {
        mensagem = "Dados enviados com sucesso";
      });
      Timer(Duration(seconds: 4),(){
        setState(() {
          mensagem="";
        });
      });

    }catch(e){
      setState(() {
        erro = "erro ao enviar dados";
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("post page", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 95, 0, 87))),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 218, 110, 209)),
        body: Center(
          child: Column(
            children: [
              Text("Insira a sua temperatura", style: TextStyle(fontSize: 33, color: const Color.fromARGB(255, 218, 110, 209)),),
                TextField(
                  controller: novatemperatura,
                ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: postValue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 109, 5, 100)
              ),
               child: 
               
               Text("inserir dados no banco!", 
               style: TextStyle(color: const Color.fromARGB(255, 218, 110, 209)),)),
              Text("$mensagem", style: TextStyle(color: const Color.fromARGB(255, 218, 110, 209)),),
              Text("$erro", style: TextStyle(color: const Color.fromARGB(255, 218, 110, 209)))
            ],
          ),
        ),
      ),
    );
  }
}