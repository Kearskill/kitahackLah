// Step 3 : Tanda Vital
// lib/features/triage/widgets/vitals_step.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
  const VitalsStep({super.key});
  
  @override
  State<VitalsStep> createState() => _VitalsStepState();
}

class _VitalsStepState extends State<VitalsStep> {

  String gulaDarahType = "";
  String dengueResult = "";
  String malariaResult = "";

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
                  "36.5", 
                  "°C", 
                  "Normal: 36.5-37.5"
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildVitalItem(
                  "Kadar Nadi",
                  "80",
                  "/min",
                  "Normal: 60-100",
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
                  "120/80",
                  "mmHg",
                  "Normal: 90/60 - 120/80",
                )
              ),
              const SizedBox(width: 16),

              Expanded(
                child: _buildVitalItem(
                  "Kadar Pernafasan",
                  "16",
                  "/min",
                  "Normal: 12-20",
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
                        _buildRoundedTextField("5.5", "mmol/L"),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            _selectionButton(
                              currentValue: gulaDarahType,
                              buttonValue: "Puasa",
                              onSelected: (val) => gulaDarahType = val,
                            ),
                            const SizedBox(width: 12),
                            _selectionButton(
                              currentValue: gulaDarahType,
                              buttonValue: "Rawak",
                              onSelected: (val) => gulaDarahType = val,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Hemoglobin",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        _buildRoundedTextField("13.5", "g/dL"),
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
                              currentValue: dengueResult,
                              buttonValue: "Positif",
                              onSelected: (val) => dengueResult = val,
                            ),
                            _selectionButton(
                              currentValue: dengueResult,
                              buttonValue: "Negatif",
                              onSelected: (val) => dengueResult = val,
                            ),
                            _selectionButton(
                              currentValue: dengueResult,
                              buttonValue: "Tidak Dibuat",
                              onSelected: (val) => dengueResult = val,
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
                              currentValue: malariaResult,
                              buttonValue: "Positif",
                              onSelected: (val) => malariaResult = val,
                            ),
                            _selectionButton(
                              currentValue: malariaResult,
                              buttonValue: "Negatif",
                              onSelected: (val) => malariaResult = val,
                            ),
                            _selectionButton(
                              currentValue: malariaResult,
                              buttonValue: "Tidak Dibuat",
                              onSelected: (val) => malariaResult = val,
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: value,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
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
        ),
      ],
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
