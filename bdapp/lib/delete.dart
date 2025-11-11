import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  //aqui a gente coda a lógica
  List<dynamic>? valores;
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
        });
      }
    );
  }

  //deletar é igual ao post, eu deleto e ai essa requisição vai para o banco e no futuro depois disso que sera deletada, ent ela é assincrona
  //precisa receber um id para deletar o documento == registro
  //id no firebase sempre é string - exemplo: "892323gasdasfdgah!#"
  Future<void> deleteValue (String id) async{
    FirebaseFirestore.instance.collection("monitoramento").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de delete"),),
        body: valores == null? Center(child: CircularProgressIndicator(),): 
        ListView.builder(
          itemCount: valores!.length , //quantos itens irei criar? R: O tamanho da lista valores
          itemBuilder: (context, index){ //o que eu irei criar
            final item = valores![index];
            return ListTile(
              title: Text("Temperatura"),
              subtitle: Text("${item["temperatura"]}"),
              trailing: GestureDetector(
                child: Icon(Icons.remove),
                onTap: (){
                  deleteValue(item.id);
                },
              ),
            );
          },
        )
      ),
    );
  }
}