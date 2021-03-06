// ignore_for_file: unnecessary_this, unused_local_variable, avoid_print, unnecessary_new

import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/interno.dart';

class InternosService extends ChangeNotifier {
  final String _baseUrl =
      'penitenciario-8005d-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Interno> internos = [];
  late Interno selectedInterno;
  final storage = new FlutterSecureStorage();

  File? newPictureFile;
  final _dio = new Dio();
  bool isLoading = true;
  bool isSaving = false;

  InternosService() {
    this.loadInternos();
  }

  Future getInternoByNiss(String niss) async {
    Interno interno = new Interno();

    final url =
        'https://penitenciario-8005d-default-rtdb.europe-west1.firebasedatabase.app/interno/$niss/surname';

    final resp = await _dio.get(url);

    final List<dynamic> internoList = resp.data;

    return internoList.map((obj) => Interno.fromJson(obj)).toList();
  }

  Future<List<Interno>> loadInternos() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/interno.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> internosMap = json.decode(resp.body);

    internosMap.forEach((key, value) {
      final tempInterno = Interno.fromMap(value);
      tempInterno.niss = key;
      this.internos.add(tempInterno);
    });

    this.isLoading = false;
    notifyListeners();

    return this.internos;
  }

  Future saveOrCreateInterno(Interno interno) async {
    isSaving = true;
    notifyListeners();

    if (interno.niss == null) {
      // Es necesario crear
      await this.createInterno(interno);
    } else {
      // Actualizar
      await this.updateInterno(interno);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateInterno(Interno interno) async {
    final url = Uri.https(_baseUrl, '/interno/${interno.niss}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: interno.toJson());
    final decodedData = resp.body;

    final index =
        this.internos.indexWhere((element) => element.niss == interno.niss);
    this.internos[index] = interno;

    return interno.niss!;
  }

  Future<String> createInterno(Interno interno) async {
    final url = Uri.https(_baseUrl, '/interno.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: interno.toJson());
    //final decodedData = json.decode(resp.body);

    //interno.niss = decodedData['niss'];

    this.internos.add(interno);

    return interno.niss!;
  }

  void updateSelectedInternoImage(String path) {
    this.selectedInterno.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dkk5i0sua/image/upload?upload_preset=penitenciario');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
