import 'package:flutter/material.dart';

void main() {
  runApp(const CalcularIMC());
}

class CalcularIMC extends StatelessWidget {
  const CalcularIMC({super.key});

  @override
  Widget build(BuildContext context) {
   return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
   );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados!";

  //Para validar a entrada de dados e nao aceitar input vazio
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infoText = "Informe seus dados!";

      //Para o _resetFields funcionar corretamente caso
      //o usuario nao digite nada em um dos campos vamos
      //inserir a linha abaixo:
      _formKey = GlobalKey<FormState>();
    });
  }

  //Calculando o peso
  void _calculate() {
    //Para que a variavel _infoText seja alterada temos que jogar todos os ifs dentro do setState.
    setState(() {
      //Pegando o peso
      double weight = double.parse(weightController.text);

      //Pegando a altura.
      double height = double.parse(heightController.text) / 100;

      //calculando IMC.
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 29.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 34.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  } //calculate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,

        //A??oes da barra.
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ) //IconButton
        ],
      ), //AppBar
      backgroundColor: Colors.white,

      //Para nao dar erro de overflow na tela usamos o SingleChieldScrolView
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

        child: Form(
          key: _formKey,
          child: Column(
            //Preenchendo toda a largura.
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ), //Icon

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ), //InputDecoration

                //Pegando o input atrav??s do centro
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),

                controller: weightController,
                
                //Validando a entrada de dados
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o seu Peso!";
                  }
                  return null;
                },
              ), //TextField

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ), //InputDecoration

                //Pegando o input atrav??s do centro
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o sua Altura!";
                  }
                  return null;
                },
              ), //TextField

              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                //Melhorando a cara do bott??o usando um SizedBox.
                //definindo a altura do bot??o com height: 50
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff008000),
                    ),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ), //ElevatedButton
                ),
              ), //Container

              //Para que a variavel _infoText seja alterada aqui
              //todos os recursos do m??todo calculate() tem que estar dentro de um setState.
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ), //TextStyle
              ) //Text
            ],
          ), //Column
        ), //Form
      ), //SingleChieldScrollView
    ); //Scaffold
  }
}