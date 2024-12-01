import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageConverterPage extends StatefulWidget {
  ImageConverterPage({super.key});

  @override
  State<ImageConverterPage> createState() => _ImageConverterPageState();
}

class _ImageConverterPageState extends State<ImageConverterPage> {
  Future<void> convertWebpToPng(File webpFile) async {
    // print("Convertendo...");
    // Ler o arquivo como bytes
    final reader = FileReader();
    reader.readAsArrayBuffer(webpFile);
    await reader.onLoadEnd.first;

    // Obter os bytes da imagem
    Uint8List webpBytes = Uint8List.fromList(reader.result as List<int>);

    // Decodificar a imagem WEBP
    img.Image? webpImage = img.decodeWebP(webpBytes);
    if (webpImage == null) {
      print("Falha ao decodificar a imagem WEBP.");
      return;
    }

    // Converter para PNG
    Uint8List pngBytes = Uint8List.fromList(img.encodePng(webpImage));

    // Criar um link para download do PNG
    final blob = Blob([pngBytes]);
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)
      ..download = "converted_image.png"
      ..style.display = "none";

    // Adicionar e clicar no link para iniciar o download
    document.body?.append(anchor);
    anchor.click();
    anchor.remove();

    // Revogar o URL para liberar memória
    Url.revokeObjectUrl(url);

    // print("Conversão concluída.");
  }

  void pickImage() {
    // Abrir o seletor de arquivos
    final input = FileUploadInputElement()..accept = '.webp';
    input.click();

    // Quando o arquivo for selecionado, converte-o
    input.onChange.listen((event) {
      if (input.files != null && input.files!.isNotEmpty) {
        convertWebpToPng(input.files!.first);
        // print("Convertendo");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900], // Cor de fundo
      appBar: AppBar(
        title: const Text(
          'Image Converter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800], // Centraliza o título
      ),
      body: Center(
          child: SizedBox(
        height: 68,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: InkWell(
              onTap: pickImage,
              child: Container(
                color: Colors.green[700],
                child: const Center(
                  child: Text(
                    'Selecionar Imagem WEBP',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
