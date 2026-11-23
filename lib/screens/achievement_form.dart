import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class AchievementForm extends StatefulWidget {
  const AchievementForm({super.key});

  @override
  State<AchievementForm> createState() => _AchievementFormPageState();
}

class _AchievementFormPageState extends State<AchievementForm> {
  final _formKey = GlobalKey<FormState>();  

  String _title = "";
  String _year = "";
  String _organization = "";
  String? _rank;
  String _description = "";

  final List<String> _ranks = [
    "Gold",
    "Silver",
    "Bronze",
    "Finalist",
  ];

  String? _validateText(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "$label wajib diisi!";
    if (maxLength != null && text.length > maxLength) {
      return "$label maksimal $maxLength karakter!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Tambah Achievement")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Achievement title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Achievement",
                    labelText: "Nama Achievement",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama achievement tidak boleh kosong!";
                    }
                    return _validateText(value, "Nama achievement", maxLength: 255);
                  },
                ),
              ),


              // === Year ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "2026",
                    labelText: "Tahun",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _year = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tahun pengalaman tidak boleh kosong!";
                    }
                    return _validateText(value, "Tahun", maxLength: 255);
                  },
                ),
              ),

              // === Organization ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Organisasi/Institusi Pengalaman",
                    labelText: "Organisasi/Institusi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _organization = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Organisasi achievement tidak boleh kosong!";
                    }
                    return _validateText(value, "Organisasi", maxLength: 255);
                  },
                ),
              ),

              // === Rank ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Rank",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _rank,
                  items: _ranks
                    .map((rank) => DropdownMenuItem(
                      value: rank,
                      child: Text(rank),
                    )).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _rank = value;
                    });
                  },
                ),
              ),

              
              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  validator: (value) => _validateText(value, "Deskripsi"),
                  decoration: InputDecoration(
                    hintText: "Deskripsi singkat pengalaman",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                ),
              ),

            
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Ringkasan Pengalaman'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Achievement: $_title'),
                                    Text('Year: $_year'),
                                    Text('Organisasi: $_organization'),
                                    Text('Rank: ${_rank ?? "-"}'),
                                    Text('Deskripsi: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _title = "";
                                      _year = "";
                                      _organization = "";
                                      _rank = null;
                                      _description = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
