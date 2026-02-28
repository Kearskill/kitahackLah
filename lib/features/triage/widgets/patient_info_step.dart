// Step 1: Maklumakt Pesakit
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';


class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 8) {
      digits = digits.substring(0, 8);
    }

    String formatted = '';

    if (digits.length >= 1) {
      formatted += digits.substring(0, digits.length >= 2 ? 2 : digits.length);
    }

    if (digits.length > 2) {
      formatted += '-';
      formatted += digits.substring(2, digits.length >= 4 ? 4 : digits.length);
    }

    if (digits.length > 4) {
      formatted += '-';
      formatted += digits.substring(4);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
class PatientInfoStep extends StatefulWidget {
  final CaseDraft draft;
  const PatientInfoStep({
    super.key,
    required this.draft,
  });

  @override
  State<PatientInfoStep> createState() => _PatientInfoStepState();
}

class _PatientInfoStepState extends State<PatientInfoStep> {

  final List<String> penyakitKronikList = [
    "Tiada",
    "Diabetes",
    "Asma",
    "Hipertensi",
    "Jantung",
    "Buah Pinggang",
    "Lain-lain",
  ];
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
          _buildRoundedTextField(
            hint: "Nama penuh pesakit",
            onChanged: (value) {
              widget.draft.name = value;
            },
          ),
          const SizedBox(height: 20),
          
          
          const Text(
            "Umur", 
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          _buildRoundedTextField(
            hint: "Umur",
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) {
              widget.draft.age = int.tryParse(value) ?? 0;
            },
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
                        if (widget.draft.penyakitKronik.contains("Lain-lain")) ...[
                          const SizedBox(height: 16),
                          _buildRoundedTextField(
                            hint: "Nyatakan penyakit kronik lain",
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              widget.draft.penyakitKronikLain = value;
                            },
                          ),
                        ],
                        const SizedBox(height: 20),
                        
                        
                        const Text(
                          "Alahan Ubat",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField(
                          hint: "Contoh: Penincillin, Aspirin",
                          onChanged: (value){
                            widget.draft.drugAllergy = value;
                          }
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Ubat Semasa",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField(
                          hint : "Senarai ubat diambil", 
                          onChanged: (value){
                            widget.draft.currentMedication = value;
                          }
                        ),
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
                          inputFormatters: [DateInputFormatter()],
                            onChanged: (value) {
                              final parts = value.split("-");
                              if (parts.length == 3) {
                                try {
                                  widget.draft.lastClinicVisit = DateTime(
                                    int.parse(parts[2]),
                                    int.parse(parts[1]),
                                    int.parse(parts[0]),
                                  );
                                } catch (_) {
                                  widget.draft.lastClinicVisit = null;
                                }
                              } else {
                                widget.draft.lastClinicVisit = null;
                              }
                            },
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
                            enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey.shade400),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        
                        const Text(
                          "Sebab Lawatan Lepas (Pilihan)",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField(
                          hint: "Contoh: Sakit kepala, Demam",
                          onChanged: (value){
                            widget.draft.pastVisitReason = value;
                          } 
                        ),
                        const SizedBox(height: 20),

                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            "Kes Susulan?",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          value: widget.draft.isFollowUp,
                          onChanged: (value) {
                            setState(() {
                              widget.draft.isFollowUp = value;
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

  Widget _buildRoundedTextField({
    required String hint,
    String suffix = "",
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
Widget _genderButton(String val, IconData icon) {
  bool isSelected = widget.draft.gender == val;

  return Expanded(
    child: OutlinedButton.icon(
      onPressed: () {
        setState(() {
          widget.draft.gender = val;
        });
      },
      icon: Icon(icon),
      label: Text(val),
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Colors.blue.shade50 : Colors.white,
        side: BorderSide(
          color:
              isSelected ? Colors.blue : Colors.grey.shade300,
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
        final isSelected = widget.draft.penyakitKronik.contains(val);

        return OutlinedButton(
          onPressed: () {
            setState(() {
              if (isSelected) {
                widget.draft.penyakitKronik.remove(val);
              } else {
                widget.draft.penyakitKronik.add(val);
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

    if (widget.draft.lastClinicVisit != null) {
      initialDate = widget.draft.lastClinicVisit!;
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      widget.draft.lastClinicVisit = picked;

      dateController.text =
          "${picked.day.toString().padLeft(2, '0')}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.year}";
    }
  }
}
