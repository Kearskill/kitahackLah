// Step 3 : Tanda Vital
// lib/features/triage/widgets/vitals_step.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';


class BloodPressureFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 3) {
      digits = digits.substring(0, 3) + '/' + digits.substring(3);
    }

    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}


class VitalsStep extends StatefulWidget {
  final CaseDraft draft;
  const VitalsStep({
    super.key,
    required this.draft,
  });
  
  @override
  State<VitalsStep> createState() => _VitalsStepState();
}

class _VitalsStepState extends State<VitalsStep> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: _buildVitalItem(
                  "Suhu Badan",
                  "",
                  "°C", 
                  "Normal: 36.5-37.5",
                  onChanged: (value) {
                    widget.draft.vitals["suhu"] =
                    double.tryParse(value);
                  }
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildVitalItem(
                  "Kadar Nadi",
                  "",
                  "/min",
                  "Normal: 60-100",
                  onChanged: (value) {
                    widget.draft.vitals["nadi"] =
                    double.tryParse(value);
                  }
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildVitalItem(
                  "Tekanan Darah",
                  "",
                  "mmHg",
                  "Normal: 90/60 - 120/80",
                  onChanged: (value) {
                    widget.draft.vitals["bp"] =
                    double.tryParse(value);
                  }
                )
              ),
              const SizedBox(width: 16),

              Expanded(
                child: _buildVitalItem(
                  "Kadar Pernafasan",
                  "",
                  "/min",
                  "Normal: 12-20",
                  onChanged: (value) {
                    widget.draft.vitals["kadar pernafasan"] =
                    double.tryParse(value);
                  }
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),

          const SizedBox(height: 20),
          _buildSpo2Card(),
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
                  "Ujian Darah (Pilihan)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                children: [
                  Padding(
                    padding:const EdgeInsets.all(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        const Text(
                          "Gula Darah",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField(
                          "",
                          "mmol/L",
                          onChanged: (value) {
                            widget.draft.vitals["gula darah"] =
                            double.tryParse(value);
                          },
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            _selectionButton(
                              currentValue: widget.draft.vitals["gula darah type"] ?? "",
                              buttonValue: "Puasa",
                              onSelected: (val) => widget.draft.vitals["gula darah type"] = val,
                            ),
                            const SizedBox(width: 12),
                            _selectionButton(
                              currentValue: widget.draft.vitals["gula darah type"] ?? "",
                              buttonValue: "Rawak",
                              onSelected: (val) => widget.draft.vitals["gula darah type"] = val,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Hemoglobin",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField(
                          "",
                          "g/dL",
                          onChanged: (value) {
                            widget.draft.vitals["hemoglobin"] =
                            double.tryParse(value);
                          },
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Ujian Pantas Dengue",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _selectionButton(
                              currentValue: widget.draft.vitals["dengue"] ?? "",
                              buttonValue: "Positif",
                              onSelected: (val) => widget.draft.vitals["dengue"] = val,
                            ),
                            _selectionButton(
                              currentValue: widget.draft.vitals["dengue"] ?? "",
                              buttonValue: "Negatif",
                              onSelected: (val) => widget.draft.vitals["dengue"] = val,
                            ),
                            _selectionButton(
                              currentValue: widget.draft.vitals["dengue"] ?? "",
                              buttonValue: "Tidak Dibuat",
                              onSelected: (val) => widget.draft.vitals["dengue"] = val,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Ujian Pantas Malaria",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _selectionButton(
                              currentValue: widget.draft.vitals["malaria"] ?? "",
                              buttonValue: "Positif",
                              onSelected: (val) => widget.draft.vitals["malaria"] = val,
                            ),
                            _selectionButton(
                              currentValue: widget.draft.vitals["malaria"] ?? "",
                              buttonValue: "Negatif",
                              onSelected: (val) => widget.draft.vitals["malaria"] = val,
                            ),
                            _selectionButton(
                              currentValue: widget.draft.vitals["malaria"] ?? "",
                              buttonValue: "Tidak Dibuat",
                              onSelected: (val) => widget.draft.vitals["malaria"] = val,
                            ),
                          ],
                        ),
                      ],
                    ), 
                  ),
                ],
              )
            )
          ),
          const SizedBox(height:20),     
        ],
      ),
    );
  }

  Widget _buildVitalField(
    String value,
    String unit,
    String hint, {
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.number,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: value,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixText: unit,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (hint.isNotEmpty)
          Text(
            hint,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildVitalItem(
    String label,
    String value,
    String unit,
    String hint, {
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.number,
    Function(String)? onChanged,  
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        _buildVitalField(
          value,
          unit,
          hint,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onChanged: onChanged,   
        ),
      ],
    );
  }

  Widget _buildRoundedTextField(
    String hint,
    String suffix, {
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
    );
  }

  Widget _buildSpo2Card() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.air,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "SpO2 (Oxygen Saturation)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Input
          TextFormField(
            initialValue: "",
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            onChanged: (value) {
              widget.draft.vitals["suhu"] =
              double.tryParse(value);
            },
            decoration: InputDecoration(
              hintText: "",
              suffixText: "%",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Normal: ≥95%",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

Widget _selectionButton({
  required String currentValue,
  required String buttonValue,
  required Function(String) onSelected,
  }) {
    bool isSelected = currentValue == buttonValue;

    Color activeColor;

    switch (buttonValue) {
      case "Positif":
        activeColor = Colors.red;
        break;
      case "Negatif":
        activeColor = Colors.green;
        break;
      case "Tidak Dibuat":
        activeColor = Colors.grey;
        break;
      default:
        activeColor = Colors.blue;
    }

    return OutlinedButton(
      onPressed: () => setState(() => onSelected(buttonValue)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        backgroundColor:
            isSelected ? activeColor.withOpacity(0.1) : Colors.white,
        side: BorderSide(
          color: isSelected ? activeColor : Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonValue,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? activeColor : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
