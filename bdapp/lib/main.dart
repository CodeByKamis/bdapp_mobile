import 'package:bdapp/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {//asyn porq ele espera o firebase conecar no app
  WidgetsFlutterBinding.ensureInitialized(); //função para inicializar os componentes que utilizam o firebase
  await Firebase.initializeApp( //aguarda o firebase iniciar
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaGet(),
    );
  }
}
class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  String? temperatura; //a variavel pode ser nula, caso o database não exista
  @override
  void initState(){
    super.initState();
    gettemp();
  }
  void gettemp(){
    //collection é o nome da sua coleçõ, precisa ser o mesmo nome escolhido no banco de dados
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(//snapsshots é os dados retornados do banco e o listen é para listar eles
    (snapshot){//o que vc irá fazer para cada um?
    //dynamic pode ser qualque tipo de dado
    dynamic data = snapshot.docs.first.data();//data == ao primeiro documento que tem no seu banco
    setState(() {
      temperatura = data['temperatura'];
    });

    }

    );
  }

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Kamila", style: TextStyle(color: Color.fromARGB(255, 218, 110, 209), fontWeight: FontWeight.bold) ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 95, 0, 87),
        ),
        body:Center(child:Column(
          children: [
            const SizedBox(height: 40),
            Text("$temperatura", style: TextStyle(color: const Color.fromARGB(255, 218, 110, 209), fontSize: 23, )),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 95, 0, 87),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
            ),
            child: Text("Ir para pagina post", 
            style: TextStyle(
              color: const Color.fromARGB(255, 218, 110, 209),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),),)
          ],
        ),
        ),
      ),
    );
  }

}