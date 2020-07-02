import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String ibge;
  final String uf;
  Result(this.cep, this.logradouro, this.bairro, this.localidade, this.ibge, this.uf);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('CEP ENCONTRADO')),
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(child: Text('CEP: $cep', style: TextStyle(color: Colors.white))),
              Container(child: Text('LOGRADOURO: $logradouro', style: TextStyle(color: Colors.white))),
              Container(child: Text('BAIRRO: $bairro', style: TextStyle(color: Colors.white))),
              Text('LOCALIDADE: $localidade', style: TextStyle(color: Colors.white)),
              Text('IBGE: $ibge', style: TextStyle(color: Colors.white)),
              Text('UF: $uf', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
