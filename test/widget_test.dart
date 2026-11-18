import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';

Finder input(String label) => find.byWidgetPredicate(
  (widget) => widget is TextField && widget.decoration?.labelText == label,
);

Future<void> fill(WidgetTester tester, String label, String value) async {
  await tester.ensureVisible(input(label));
  await tester.enterText(input(label), value);
  await tester.pump();
}

Future<void> save(WidgetTester tester) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Simpan'));
  await tester.tap(find.widgetWithText(ElevatedButton, 'Simpan'));
  await tester.pumpAndSettle();
}

Future<void> date(WidgetTester tester, String label, String value) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.edit_outlined));
  await tester.pumpAndSettle();
  final field = find.descendant(
    of: find.byType(DatePickerDialog),
    matching: find.byType(TextField),
  );
  await tester.enterText(field, value);
  await tester.tap(find.widgetWithText(TextButton, 'OK'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Experience rejects whitespace, long names and malformed logos', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ExperienceForm()));
    await fill(tester, 'Nama Pengalaman', '   ');
    await fill(tester, 'Organisasi/Institusi Pengalaman', '   ');
    await fill(tester, 'Deskripsi', '   ');
    await fill(tester, 'Tautan gambar', 'not a URL');
    await save(tester);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Nama pengalaman tidak boleh kosong!'), findsOneWidget);
    expect(
      find.text('Organisasi pengalaman tidak boleh kosong!'),
      findsOneWidget,
    );
    expect(find.text('Deskripsi wajib diisi!'), findsOneWidget);
    expect(find.text('Tanggal mulai wajib diisi!'), findsOneWidget);
    expect(
      find.text('Masukkan URL logo HTTP/HTTPS yang valid!'),
      findsOneWidget,
    );
    await fill(tester, 'Nama Pengalaman', 'a' * 256);
    await save(tester);
    expect(find.text('Nama pengalaman maksimal 255 karakter!'), findsOneWidget);
  });

  testWidgets(
    'Experience preserves every input, checks dates and resets all state',
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ExperienceForm()));
      await fill(tester, 'Nama Pengalaman', 'Teaching Assistant');
      await fill(
        tester,
        'Organisasi/Institusi Pengalaman',
        'Universitas Indonesia',
      );
      await fill(tester, 'Tautan gambar', 'https://example.com/logo.png');
      await fill(tester, 'Lokasi', 'Depok');
      await fill(tester, 'Deskripsi', 'Membantu praktikum');
      await fill(tester, 'Skills (opsional)', 'Django, Leadership');
      await date(tester, 'Pilih tanggal mulai', '01/02/2026');
      await date(tester, 'Pilih tanggal selesai (opsional)', '01/01/2026');
      await save(tester);
      expect(
        find.text('Tanggal selesai tidak boleh sebelum tanggal mulai!'),
        findsOneWidget,
      );
      expect(find.byType(AlertDialog), findsNothing);
      await date(tester, 'Selesai: 1/1/2026', '01/03/2026');
      await save(tester);
      expect(find.text('Ringkasan Pengalaman'), findsOneWidget);
      for (final line in [
        'Nama Pengalaman: Teaching Assistant',
        'Organisasi: Universitas Indonesia',
        'Organization logo: https://example.com/logo.png',
        'Lokasi: Depok',
        'Deskripsi: Membantu praktikum',
        'Skills: Django, Leadership',
        'Tanggal Mulai: 2/1/2026',
        'Tanggal Selesai: 3/1/2026',
      ]) {
        expect(find.text(line), findsOneWidget);
      }
      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await tester.pumpAndSettle();
      expect(find.text('Pilih tanggal mulai'), findsOneWidget);
      expect(find.text('Pilih tanggal selesai (opsional)'), findsOneWidget);
      for (final editable in tester.widgetList<EditableText>(
        find.byType(EditableText),
      )) {
        expect(editable.controller.text, isEmpty);
      }
      await fill(tester, 'Nama Pengalaman', 'Pengalaman kedua');
      await fill(tester, 'Organisasi/Institusi Pengalaman', 'Organisasi kedua');
      await fill(tester, 'Lokasi', 'Jakarta');
      await fill(tester, 'Deskripsi', 'Deskripsi kedua');
      await date(tester, 'Pilih tanggal mulai', '02/01/2026');
      await save(tester);
      expect(find.text('Organization logo: '), findsOneWidget);
      expect(find.text('Skills: '), findsOneWidget);
      expect(find.text('Tanggal Selesai: Masih berlangsung'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
