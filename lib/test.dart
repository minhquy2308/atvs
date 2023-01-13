import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<DichVu>> fetchDichVu(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8888/database_flutter/getalldichvu.php'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseDichVu, response.body);
}

// A function that converts a response body into a List<Photo>.
List<DichVu> parseDichVu(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<DichVu>((json) => DichVu.fromJson(json)).toList();
}

class DichVu {
  final String id;
  final String ten_dichvu;

  const DichVu({
    required this.id,
    required this.ten_dichvu,
  });

  factory DichVu.fromJson(Map<String, dynamic> json) {
    return DichVu(
      id: json['id'] as String,
      ten_dichvu: json['ten_dichvu'] as String,

    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<DichVu>>(
        future: fetchDichVu(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return DanhSachDichVu(cacDichVu: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class DanhSachDichVu extends StatelessWidget {
  const DanhSachDichVu({super.key, required this.cacDichVu});

  final List<DichVu> cacDichVu;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: cacDichVu.length,
      itemBuilder: (context, index) {
        dv.add(cacDichVu[index].ten_dichvu);
        print(dv);
        return Text(cacDichVu[index].ten_dichvu);
      },
    );
  }
}