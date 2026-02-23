// Step 1: Maklumakt Pesakit
import 'package:flutter/material.dart';

class PatientInfoStep extends StatefulWidget {
  const PatientInfoStep({super.key});

  @override
  State<PatientInfoStep> createState() => _PatientInfoStepState();
}

class _PatientInfoStepState extends State<PatientInfoStep> {
  String gender = 'Lelaki';

  final List<String> penyakitKronikList = [
    "Tiada",
    "Diabetes",
    "Asma",
    "Hipertensi",
    "Jantung",
    "Buah Pinggang",
    "Lain-lain",
  ];

  List<String> selectedPenyakitKronik = [];
  final TextEditingController otherController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool isFollowUp = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          const Text(
            "Nama Pesakit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildRoundedTextField("Nama penuh pesakit", ""),
          const SizedBox(height: 20),
          
          
          const Text(
            "Umur", 
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              hintText: "0",

              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          
          
          const Text("Jantina", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _genderButton("Lelaki", Icons.male),
              const SizedBox(width: 16),
              _genderButton("Perempuan", Icons.female),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.shade300
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ExpansionTile(
                childrenPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text(
                  "Sejarah Perubatan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                children: [
                  Padding(
                    padding:const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Penyakit Kronik",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),

                        _buildPenyakitGrid(),
                        if (selectedPenyakitKronik.contains("Lain-lain")) ...[
                          const SizedBox(height: 16),
                          _buildRoundedTextField("Nyatakan penyakit kronik lain", ""),
                        ],
                        const SizedBox(height: 20),
                        
                        
                        const Text(
                          "Alahan Ubat",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField("Contoh: Penincillin, Aspirin", ""),
                        const SizedBox(height: 20),

                        const Text(
                          "Ubat Semasa",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField("Senarai ubat diambil", ""),
                        const SizedBox(height: 20),
                      ],
                    ), 
                  ),
                ],
              )
            )
          ),
          const SizedBox(height:20),


          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.shade300
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ExpansionTile(
                childrenPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text(
                  "Lawatan Lepas",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                children: [
                  Padding(
                    padding:const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Lawatan terakhir ke klinik",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: dateController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: "DD-MM-YYYY",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        
                        const Text(
                          "Sebab Lawatan Lepas",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField("Contoh: Sakit kepala, Demam", ""),
                        const SizedBox(height: 20),

                        const Text(
                          "Ubat Semasa",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField("Senarai ubat diambil", ""),
                        const SizedBox(height: 10),

                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Kes Susulan?",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          value: isFollowUp,
                          onChanged: (value) {
                            setState(() {
                              isFollowUp = value;
                            });
                          },
                        )
                      ],
                    ), 
                  ),
                ],
              )
            )
          ) 
        ],
      ),
    );
  }

  Widget _buildRoundedTextField(
      String hint, 
      String suffix, 
    ){
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
  Widget _genderButton(String val, IconData icon) {
    bool isSelected = gender == val;
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () => setState(() => gender = val),
        icon: Icon(icon),
        label: Text(val),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.shade50 : Colors.white,
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildPenyakitGrid() {
    return Wrap(
      spacing: 6,
      runSpacing: 0,
      children: penyakitKronikList.map((val) {
        final isSelected = selectedPenyakitKronik.contains(val);

        return OutlinedButton(
          onPressed: () {
            setState(() {
              if (isSelected) {
                selectedPenyakitKronik.remove(val);
              } else {
                selectedPenyakitKronik.add(val);
              }
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor:
                isSelected ? Colors.blue.shade50 : Colors.white,
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(val),
        );
      }).toList(),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    // Try parsing existing typed date
    if (dateController.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(dateController.text);
      } catch (_) {}
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateController.text =
          "${picked.day}-${picked.month}-${picked.year}";
    }
  }
}
