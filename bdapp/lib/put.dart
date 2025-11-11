import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PutPage extends StatefulWidget {
  const PutPage({super.key});

  @override
  State<PutPage> createState() => _PutPageState();
}

class _PutPageState extends State<PutPage> {
  List<dynamic>? valores;
  //variavel que observa o que o usuario digita
  Map<String, TextEditingController> controladores = {}; //map para colocar uma variavel observadora em cada campo de texto
  @override
  void initState(){ //reiniciar a pagina
  super.initState();
  getValues();
  }

  void getValues() async{
    //crio uma instancia do firebase na coleção monitoramento
    // os retornos (snapshorts) -> instantaneo
    //ouvir /listar os retornos (listen)
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshots){
        final data = snapshots.docs; //variavel que contem todos os registros do banco
        setState(() {
          valores = data;
          for (dynamic doc in data){
            controladores[doc.id] = TextEditingController();

          }
        });
      }
    );
  }
  Future<void> PutValue(String id) async{
    FirebaseFirestore.instance.collection("monitoramento").doc(id).set( //set é o put
      {
        "temperatura": controladores[id]!.text,
      }
    );
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de Put")),
        body: valores == null? Center(child: CircularProgressIndicator()) :
        ListView.builder(itemCount: valores!.length,
        itemBuilder: (context,index){
          final item = valores![index];

          return ListTile(
            title: Text("temperatura atual: ${item["temperatura"]}"),
            subtitle: Column(
              children: [
                TextField(controller: controladores[item.id]),
                ElevatedButton(onPressed: (){PutValue(item.id);}, child: Text("Clique para Alterar"))
              ],
            ),
          );

        },
        )
      )
    );
  }
}