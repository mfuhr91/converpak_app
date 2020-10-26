import 'dart:math';

import 'package:converpak/src/models/moneda_model.dart';
import 'package:converpak/src/services/moneda_service.dart';
import 'package:converpak/src/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pagina extends StatefulWidget {
  @override
  _PaginaState createState() => _PaginaState();
}

class _PaginaState extends State<Pagina> {
  Future<List<Moneda>> _cotizaciones;
  final _monedaService = new MonedaService();
  final _montoField = TextEditingController();

  @override
  void initState() {
    super.initState();

    _cotizaciones = _monedaService.getCotizaciones();
    _montoField.addListener(() {
      _calcular();
    });
  }

  IconData iconMonto = FontAwesomeIcons.dollarSign;
  IconData iconTotal = FontAwesomeIcons.euroSign;

  bool pesoAEuro = true;
  double monto = 0.00;
  double _valorEuro = 0.00;
  double _valorBitcoin = 0.00;
  double _monedaConvertida = 0.00;
  double _bitcoinConvertido = 0.00;

  @override
  void dispose() {
    _montoField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig appConfig = new AppConfig();
    final color = Theme.of(context).accentColor;

    appConfig.width = MediaQuery.of(context).size.width;
    appConfig.height = MediaQuery.of(context).size.height;
    appConfig.bloque = appConfig.width / 100;
    appConfig.fontSize = appConfig.bloque * 6;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _campoMonto(color, appConfig),
            _cotizacion(color, appConfig),
            SizedBox(height: 10.0),
            _totalMoneda(color, appConfig),
            _totalBitcoin(color, appConfig),
            _selector(color, appConfig),
          ],
        ),
      ),
    );
  }

  Widget _campoMonto(Color color, AppConfig appConfig) {
    return Container(
      width: appConfig.width * 0.85,
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: TextField(
        controller: _montoField,
        style: TextStyle(
            fontSize: appConfig.fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(iconMonto, size: 27.0, color: color),
          hintStyle:
              TextStyle(fontSize: appConfig.fontSize, color: Colors.black),
          hintText: 'Ingrese un monto',
          border: InputBorder.none,
        ),
        showCursor: false,
        onChanged: (valor) {
          if (valor == '') {
            setState(() {
              _monedaConvertida = 0.00;
              _bitcoinConvertido = 0.00;
            });
          }
        },
      ),
    );
  }

  Widget _cotizacion(Color color, AppConfig appConfig) {
    return FutureBuilder(
        future: _cotizaciones,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Moneda> monedas = snapshot.data;

            monedas.forEach((element) {
              if (element.tipo.contains('euro_blue')) {
                _valorEuro = element.valor;
              } else {
                _valorBitcoin = element.valor;
              }
            });
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: 15.0),
                    width: appConfig.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      'Euro Blue:  ${monedas[0].valor}0',
                      style: TextStyle(
                          fontSize: appConfig.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: appConfig.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Bitcoin:   ${monedas[1].valor}',
                      style: TextStyle(
                          fontSize: appConfig.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                width: appConfig.width * 0.85,
                height: 125.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off, color: Colors.black, size: 45.0),
                    SizedBox(height: 5.0),
                    Text(
                      'No se puede acceder al servidor vuelva a intentarlo mas tarde.',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
          } else {
            return Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 10.0),
              width: appConfig.width * 0.85,
              height: 125.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Cargando cotizaciones',
                    style: TextStyle(
                        fontSize: appConfig.fontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        });
  }

  Widget _totalMoneda(Color color, AppConfig appConfig) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: appConfig.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(iconTotal, size: 25.0, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('  ${_monedaConvertida.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: appConfig.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _totalBitcoin(Color color, AppConfig appConfig) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: appConfig.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.bitcoin,
            size: 25.0,
            color: Color.fromRGBO(239, 143, 43, 1.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('  ${_bitcoinConvertido.toStringAsFixed(8)}',
                style: TextStyle(
                    fontSize: appConfig.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _selector(Color color, AppConfig appConfig) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _convertirAEuro(color, appConfig),
        _convertirAPeso(color, appConfig),
      ],
    ));
  }

  FlatButton _convertirAEuro(Color color, AppConfig appConfig) {
    return FlatButton(
        height: appConfig.height * 0.075,
        color: (pesoAEuro) ? color : Colors.grey[300],
        child: Row(
          children: [
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.dollarSign,
                size: 25.0, color: (pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.arrowRight,
                size: 15.0, color: (pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.euroSign,
                size: 25.0, color: (pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          setState(() {
            iconMonto = FontAwesomeIcons.dollarSign;
            iconTotal = FontAwesomeIcons.euroSign;
            pesoAEuro = true;
            _calcular();
          });
        });
  }

  FlatButton _convertirAPeso(Color color, AppConfig appConfig) {
    return FlatButton(
        height: appConfig.height * 0.075,
        color: (!pesoAEuro) ? color : Colors.grey[300],
        child: Row(
          children: [
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.euroSign,
                size: 25.0, color: (!pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.arrowRight,
                size: 15.0, color: (!pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
            Icon(FontAwesomeIcons.dollarSign,
                size: 25.0, color: (!pesoAEuro) ? Colors.white : color),
            SizedBox(width: appConfig.width * 0.025),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          setState(() {
            iconMonto = FontAwesomeIcons.euroSign;
            iconTotal = FontAwesomeIcons.dollarSign;
            pesoAEuro = false;
            _calcular();
          });
        });
  }

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  void _calcular() {
    if (_montoField.text != '') {
      monto = double.parse(_montoField.text.toString());
      if (pesoAEuro) {
        print('${(dp((monto / _valorEuro), 2)).toStringAsFixed(2)}');
        print('${(dp((monto / _valorEuro), 10))}');
        _monedaConvertida = dp((monto / _valorEuro), 2);
        _bitcoinConvertido = dp((monto / _valorBitcoin), 8);
      } else {
        print('${(dp((monto * _valorEuro), 2)).toStringAsFixed(2)}');
        _monedaConvertida = dp((monto * _valorEuro), 2);
        print('${(dp((monto * _valorEuro), 10))}');
        _bitcoinConvertido = dp(((monto * _valorEuro) / _valorBitcoin), 6);
      }
    }
    setState(() {});
  }
}
