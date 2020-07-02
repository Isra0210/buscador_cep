import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:webservice/Result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _form = GlobalKey();
    final _controllerCep = TextEditingController();

    _snackBarError(String label) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            label,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 2000),
          backgroundColor: Colors.red,
        ),
      );
    }

    Map<String, dynamic> request = {};

    _submit() async {
      if (!_form.currentState.validate()) {
        return;
      }

      try {
        String cep = _controllerCep.text.toString();
        final response = await http.get('http://viacep.com.br/ws/$cep/json/');
        print('cep: ${response.body}');
        request = json.decode(response.body);

        String logradouro = request["logradouro"];
        String bairro = request["bairro"];
        String localidade = request["localidade"];
        String ibge = request["4123501"];
        String uf = request["uf"];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Result(cep, logradouro, bairro, localidade, ibge, uf),
          ),
        );
      } catch (error) {
        _snackBarError('${error.toString()}');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Buscador de CEP')),
        backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Informe o CEP",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0),
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: _controllerCep,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return "Insira um CEP válido!";
                  }
                  return null;
                },
              ),
            ),
            !_isLoading
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.black,
                      onPressed: () => _submit(),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
