import 'dart:io';

import 'package:colomer_dental/src/connect/connection.dart';
import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({Key key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  File _image;
  final _picker = ImagePicker();
  NoticiasModel _noticiasModel = NoticiasModel();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final PublicacionesProvider _publicacionesProvider = PublicacionesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cloud_upload),
          onPressed: () async {
            if (!_formKey.currentState.validate())
              return null;
            else {
              _noticiasModel.fecha = DateTime.now().toString();
              if (_image == null) {
                _noticiasModel.fotoStatus = false;
                await _publicacionesProvider.addNew(_noticiasModel);
              } else {
                String _direccionFoto =
                    await _publicacionesProvider.subirFotoMySQL(_image);
                _noticiasModel.fotoUrl = _direccionFoto;
                _noticiasModel.fotoStatus = true;
                await _publicacionesProvider.addNew(_noticiasModel);
              }
              showDialog(
                  context: context,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ));
              Navigator.pushReplacementNamed(context, '/bottom');
            }
          }),
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: Colors.blue[600],
        title: Text('Añadir un evento'),
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () async {
                ImageSource _fuente;
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Seleccione fuente'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                _fuente = ImageSource.gallery;
                                Navigator.pop(context);
                              },
                              child: Text('Galería')),
                          FlatButton(
                              onPressed: () {
                                _fuente = ImageSource.camera;
                                Navigator.pop(context);
                              },
                              child: Text('Cámara'))
                        ],
                      );
                    });
                try {
                  final _foto =
                      await _picker.getImage(source: _fuente, imageQuality: 30);
                  _image = File(_foto.path) != null ? File(_foto.path) : null;
                  setState(() {});
                } catch (e) {
                  print(e.toString());
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: _cuerpo(context),
        ),
      ),
    );
  }

  Widget _cuerpo(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: _image == null
                ? Image(
                    image: AssetImage('assets/loading/camera_icon.png'),
                    fit: BoxFit.scaleDown,
                  )
                : Image.file(
                    File(_image.path),
                    fit: BoxFit.scaleDown,
                  ),
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Título'),
            onChanged: (valor) {
              _noticiasModel.titulo = valor;
              setState(() {});
            },
            validator: (value) {
              if (value.length < 1) return 'Debes introducir algún título';
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            maxLines: 100,
            minLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Contenido'),
            onChanged: (valor) {
              _noticiasModel.contenido = valor;
              setState(() {});
            },
            validator: (value) {
              if (value.length < 1)
                return 'Debes introducir algún tipo de descripción';
              return null;
            },
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
