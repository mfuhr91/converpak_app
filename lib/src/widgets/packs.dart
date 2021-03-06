import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/services/datos.dart';

class Packs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: datos.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            width: datos.width * 0.80,
            child: Text('Packs:',
              style: TextStyle(
                fontSize: datos.fontSize - 2,
                fontWeight: FontWeight.w700,
                color: Colors.black
              )
            ),
          ),
          SizedBox(height: 5.0),
          _pack107(datos),
          SizedBox(height: 5.0),
          _pack535(datos),
          SizedBox(height: 5.0),
          _pack1070(datos),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Container _pack107(Datos datos) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      width: datos.width * 0.80,
      decoration: BoxDecoration(
        //color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(),
      ),
      child: Row(
        children: [
          SizedBox(width: 5.0),
          Icon(FontAwesomeIcons.cube, size: datos.fontSize, color: Colors.black),
          Text(' 107€:     ',
            style: TextStyle(
              fontSize: datos.fontSize - 2,
              fontWeight: FontWeight.w400,
              color: Colors.black
            )
          ),
          Flexible(
            child: Padding(
              padding: (Platform.isAndroid) ? const EdgeInsets.only(left: 0.0) : const EdgeInsets.only(left: 4.0),
              child: Text('${datos.packs107.toStringAsFixed(2)} packs',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: datos.fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _pack535(Datos datos) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      width: datos.width * 0.80,
      decoration: BoxDecoration(
        //color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(),
      ),
      child: Row(
        children: [
          SizedBox(width: 5.0),
          Icon(FontAwesomeIcons.cube, size: datos.fontSize, color: Colors.black),
          Text(' 535€:     ',
            style: TextStyle(
              fontSize: datos.fontSize - 2,
              fontWeight: FontWeight.w400,
              color: Colors.black
            )
          ),
          Flexible(
            child: Padding(
              padding: (Platform.isAndroid) ? const EdgeInsets.only(left: 2.0) : const EdgeInsets.only(left: 0.0),
              child: Text('${datos.packs535.toStringAsFixed(2)} packs',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: datos.fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Container _pack1070(Datos datos) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      width: datos.width * 0.80,
      decoration: BoxDecoration(
        //color: Colors.grey[500],
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(),
      ),
      child: Row(
        children: [
          SizedBox(width: 5.0),
          Icon(FontAwesomeIcons.cube, size: datos.fontSize, color: Colors.black),
          Text(' 1070€:   ',
            style: TextStyle(
              fontSize: datos.fontSize - 2,
              fontWeight: FontWeight.w400,
              color: Colors.black
            )
          ),
          Flexible(
            child: Padding(
              padding: (Platform.isAndroid) ? const EdgeInsets.only(left: 0.0) : const EdgeInsets.only(left: 4.0),
              child: Text('${datos.packs1070.toStringAsFixed(2)} packs',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: datos.fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}