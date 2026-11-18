import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceForm> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _organization = "";
  String _orgLogo = ""; // default
  String _location = "";
  String _description = "";

  DateTime? _startedAt;
  DateTime? _endedAt;

  String _skills = "";

  String? _validateText(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return "$label wajib diisi!";
    if (maxLength != null && text.length > maxLength) {
      return "$label maksimal $maxLength karakter!";
    }
    return null;
  }

  String? _validateLogo(String? value) {
    final text = value?.trim() ?? "";
    if (text.isEmpty) return null;
    if (text.length > 255) return "Tautan logo maksimal 255 karakter!";
    final uri = Uri.tryParse(text);
    if (uri == null ||
        !["http", "https"].contains(uri.scheme) ||
        uri.host.isEmpty ||
        RegExp(r'\s').hasMatch(text)) {
      return "Masukkan URL logo HTTP/HTTPS yang valid!";
    }
    return null;
  }

  Widget _dateField({required bool isStart}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField<DateTime>(
        key: ValueKey(isStart ? "startedAt" : "endedAt"),
        validator: (value) {
          if (isStart && value == null) return "Tanggal mulai wajib diisi!";
          if (!isStart &&
              value != null &&
              _startedAt != null &&
              value.isBefore(_startedAt!)) {
            return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
          }
          return null;
        },
        builder: (field) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: Text(
                field.value == null
                    ? (isStart
                          ? "Pilih tanggal mulai"
                          : "Pilih tanggal selesai (opsional)")
                    : "${isStart ? 'Mulai' : 'Selesai'}: ${field.value!.day}/${field.value!.month}/${field.value!.year}",
              ),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: field.value ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (!mounted || !field.mounted || date == null) return;
                setState(() {
                  if (isStart) {
                    _startedAt = date;
                  } else {
                    _endedAt = date;
                  }
                });
                field.didChange(date);
              },
            ),
            if (!isStart && field.value != null)
              TextButton(
                onPressed: () {
                  setState(() => _endedAt = null);
                  field.didChange(null);
                },
                child: const Text("Hapus tanggal selesai"),
              ),
            if (!isStart && field.value == null)
              const Text("Kosongkan jika masih berlangsung."),
            if (field.hasError)
              Text(
                field.errorText!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tambah Pengalaman')),
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
              // === Experience Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Pengalaman",
                    labelText: "Nama Pengalaman",
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
                      return "Nama pengalaman tidak boleh kosong!";
                    }
                    return _validateText(
                      value,
                      "Nama pengalaman",
                      maxLength: 255,
                    );
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
                      return "Organisasi pengalaman tidak boleh kosong!";
                    }
                    return _validateText(value, "Organisasi", maxLength: 255);
                  },
                ),
              ),

              // === org logo path ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  validator: _validateLogo,
                  decoration: InputDecoration(
                    hintText: "https://example.com/logo.png",
                    labelText: "Tautan gambar",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _orgLogo = value!;
                    });
                  },
                ),
              ),

              // === Location ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      _validateText(value, "Lokasi", maxLength: 255),
                  decoration: InputDecoration(
                    hintText: "Depok, Jawa Barat",
                    labelText: "Lokasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _location = value!;
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

              _dateField(isStart: true),
              _dateField(isStart: false),

              // === Skills ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Python, Django, Leadership",
                    labelText: "Skills (opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _skills = value!;
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
                                    Text('Nama Pengalaman: $_title'),
                                    Text('Organisasi: $_organization'),
                                    Text('Organization logo: $_orgLogo'),
                                    Text('Lokasi: $_location'),
                                    Text('Deskripsi: $_description'),
                                    Text(
                                      'Tanggal Mulai: ${_startedAt == null ? "-" : "${_startedAt!.day}/${_startedAt!.month}/${_startedAt!.year}"}',
                                    ),
                                    Text(
                                      'Tanggal Selesai: ${_endedAt == null ? "Masih berlangsung" : "${_endedAt!.day}/${_endedAt!.month}/${_endedAt!.year}"}',
                                    ),
                                    Text('Skills: $_skills'),
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
                                      _organization = "";
                                      _orgLogo = "";
                                      _location = "";
                                      _description = "";
                                      _skills = "";
                                      _startedAt = null;
                                      _endedAt = null;
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
