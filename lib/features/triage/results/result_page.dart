import 'package:flutter/material.dart';
import 'case_model.dart';
import 'severity_enum.dart';

class ResultPage extends StatelessWidget {
  final CaseModel caseData;
  final bool isReadOnly;

  const ResultPage({
    super.key,
    required this.caseData,
    this.isReadOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _getSeverityColor(caseData.severity),
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _getColor(caseData.severity).withOpacity(0.4), // 👈 darker line
                width: 5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 72, bottom: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSeverityTitle(),
                  const Text(
                    "Ringkasan keputusan AI",
                    style: TextStyle(
                      fontSize: 14,// important for contrast
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildSeveritySections(),
          ],
        ),
      ),
    );
  }

  Color _getColor(Severity severity) {
    switch (severity) {
      case Severity.ringan:
        return Colors.green.shade900;
      case Severity.sederhana:
        return Colors.orange.shade900;
      case Severity.teruk:
        return Colors.red.shade900;
    }
  }

Color _getSeverityColor(Severity severity) {
  switch (severity) {
    case Severity.ringan:
      return Colors.green.shade100;
    case Severity.sederhana:
      return Colors.orange.shade100;
    case Severity.teruk:
      return Colors.red.shade100;
  }
}

  Widget _buildSeverityTitle() {
    switch (caseData.severity) {
      case Severity.ringan:
        return Text(
          "Penilaian: Ringan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.green.shade900,
          ),
        );

      case Severity.sederhana:
        return Text(
          "Penilaian: Sederhana",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade400,
            fontSize: 30,
          ),
        );

      case Severity.teruk:
        return Text(
          "Rujuk Segera",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent.shade700,
            fontSize: 30,
          ),
        );
    }
  } 

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [

          /// Simpan Kes (only if not read-only)
          if (!isReadOnly)
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save case logic
                },
                child: const Text("Simpan Kes"),
              ),
            ),

          if (!isReadOnly)
            const SizedBox(width: 12),

          /// Export PDF (always available)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Export PDF logic
              },
              child: const Text("Export PDF"),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSeveritySections() {
    switch (caseData.severity) {
      case Severity.ringan:
        return [
          _buildKemungkinanRingan(),
          _buildCadanganRingan(),
          _buildTandaBahaya(),
          _buildSusulan(),
        ];

      case Severity.sederhana:
        return [
          _buildKemungkinanRingan(),
          _buildCadanganSederhana(),
          _buildSementaraMenunggu(),
          _buildRujukSegeraJika(),
        ];

      case Severity.teruk:
        return [
          _buildKemungkinanSerius(),
          _buildTindakanSegera(),
          _buildTandaKritikal(),
        ];
    }
  }

  Widget _buildResultCard({
    required String title,
    required Widget child,
    IconData? icon,
    Color? accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, color: accentColor ?? Colors.black),
              if (icon != null) const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildKemungkinanRingan() {
    return _buildResultCard(
      title: "Kemungkinan Keadaan",
      icon: Icons.info_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(caseData.primaryDiagnosis),
          const SizedBox(height: 6),
          const Text("Kebarangkalian: 82%"),
        ],
      ),
    );
  }

  Widget _buildCadanganRingan() {
    return _buildResultCard(
      title: "Cadangan Tindakan",
      icon: Icons.medical_services_outlined,
      child: const Text(
        "Rawat di klinik dan rehat secukupnya.",
      ),
    );
  }

  Widget _buildTandaBahaya() {
    return _buildResultCard(
      title: "Tanda Bahaya untuk Dipantau",
      icon: Icons.warning_amber_rounded,
      accentColor: Colors.orange,
      child: const Text(
        "Jika demam melebihi 3 hari atau sesak nafas, segera rujuk doktor.",
      ),
    );
  }

  Widget _buildSusulan() {
    return _buildResultCard(
      title: "Susulan",
      icon: Icons.schedule,
      child: const Text(
        "Datang semula dalam 3 hari jika simptom berterusan.",
      ),
    );
  }

  Widget _buildCadanganSederhana() {
    return _buildResultCard(
      title: "Cadangan Tindakan",
      icon: Icons.phone,
      accentColor: Colors.orange,
      child: GestureDetector(
        onTap: () {
          // Navigate to doctor info
        },
        child: const Text(
          "Hubungi doktor untuk penilaian lanjut.",
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSementaraMenunggu() {
    return _buildResultCard(
      title: "Sementara Menunggu",
      icon: Icons.hourglass_bottom,
      child: const Text(
        "Pastikan pesakit berehat dan minum air secukupnya.",
      ),
    );
  }

  Widget _buildRujukSegeraJika() {
    return _buildResultCard(
      title: "Rujuk Segera Jika",
      icon: Icons.error_outline,
      accentColor: Colors.red,
      child: const Text(
        "Jika keadaan bertambah teruk, rujuk ke hospital.",
      ),
    );
  }

  Widget _buildKemungkinanSerius() {
    return _buildResultCard(
      title: "Kemungkinan Keadaan Serius",
      icon: Icons.report_problem,
      accentColor: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Dengue Hemorrhagic Fever"),
          SizedBox(height: 6),
          Text("Berdasarkan simptom dan tekanan darah rendah."),
        ],
      ),
    );
  }

  Widget _buildTindakanSegera() {
    return _buildResultCard(
      title: "Tindakan Segera Diperlukan",
      icon: Icons.local_hospital,
      accentColor: Colors.red,
      child: const Text(
        "Rujuk segera ke hospital terdekat.",
      ),
    );
  }

  Widget _buildTandaKritikal() {
    return _buildResultCard(
      title: "Tanda Kritikal",
      icon: Icons.warning,
      accentColor: Colors.red,
      child: const Text(
        "Pantau tekanan darah dan kadar nadi setiap 30 minit.",
      ),
    );
  }
}