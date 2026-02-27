// Step 2: Simptom Pesakit
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';


class Symptom {
  String label;
  bool selected;
  String note; // value from textfield
  String type;

  Symptom({
    required this.label,
    this.selected = false,
    this.note = "",
    this.type = "",
  });
}

class SymptomCategory {
  String title;
  IconData icon;
  List<Symptom> symptoms;

  SymptomCategory({
    required this.title,
    required this.icon,
    required this.symptoms,
  });
}

class SymptomsStep extends StatefulWidget {
    final CaseDraft draft;
    const SymptomsStep({
      super.key,
      required this.draft,
    });

  @override
  State<SymptomsStep> createState() => _SymptomsStepState();
}

class _SymptomsStepState extends State<SymptomsStep> {

late List<SymptomCategory> categories;

String searchQuery = "";
String additionalNotes = "";

  @override
  void initState() {
    super.initState();


    categories = [
      SymptomCategory(
        title: "Demam",
        icon: Icons.thermostat,
        symptoms: [
          Symptom(label: "Demam"),
          Symptom(label: "Menggigil"),
          Symptom(label: "Berpeluh"),
          Symptom(label: "Sakit kepala"),
          Symptom(label: "Lemah/Lesu"),
        ],
      ),
      SymptomCategory(
        title: "Pernafasan",
        icon: Icons.air,
        symptoms: [
          Symptom(label: "Batuk"),
          Symptom(label: "Sesak nafas"),
          Symptom(label: "Sakit tekak"),
          Symptom(label: "Hidung berair"),
          Symptom(label: "Bersin"),
        ],
      ),
      SymptomCategory(
        title: "Penghadaman",
        icon: Icons.lunch_dining,
        symptoms: [
          Symptom(label: "Sakit Perut"),
          Symptom(label: "Ciri-Birit"),
          Symptom(label: "Muntah"),
          Symptom(label: "Loya"),
          Symptom(label: "Hilang selera"),
          Symptom(label: "Sembelit"),
        ],
      ),
      SymptomCategory(
        title: "Kulit",
        icon: Icons.healing,
        symptoms: [
          Symptom(label: "Ruam"),
          Symptom(label: "Gatal"),
          Symptom(label: "Luka"),
          Symptom(label: "Bengkak"),
          Symptom(label: "Lebam"),
        ],
      ),
      SymptomCategory(
        title: "Sakit",
        icon: Icons.warning_amber_rounded,
        symptoms: [
          Symptom(label: "Sakit Kepala"),
          Symptom(label: "Sakit Belakang"),
          Symptom(label: "Sakit Sendi"),
          Symptom(label: "Sakit Otot"),
          Symptom(label: "Sakit Dada"),
        ],
      ),
      SymptomCategory(
        title: "Lain-lain",
        icon: Icons.more_horiz,
        symptoms: [
          Symptom(label: "Pening/Pitam"),
          Symptom(label: "Pengsan"),
          Symptom(label: "Sawan"),
          Symptom(label: "Pendarahan"),
          Symptom(label: "Kencing Sakit"),
        ],
      ),
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          ...categories.map((category) {
            return _buildCategory(category);
          }).toList(),  
          const SizedBox(height: 24),
          _buildAdditionalNotesBox(),
          const SizedBox(height: 24),
          _buildCameraUploadBox(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: "Cari simptom...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategory(SymptomCategory category) {
    final query = searchQuery.toLowerCase();

    final isCategoryMatch =
        category.title.toLowerCase().contains(query);

    final filteredSymptoms = category.symptoms.where((symptom) {
      return symptom.label.toLowerCase().contains(query);
    }).toList();

    // Hide category if no match
    if (!isCategoryMatch &&
        filteredSymptoms.isEmpty &&
        searchQuery.isNotEmpty) {
      return const SizedBox();
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(30),
          child: ExpansionTile(
            iconColor: Colors.grey.shade600,
          collapsedIconColor: Colors.grey.shade600,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
            childrenPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Row(
              children: [
                Icon(category.icon, color: Colors.redAccent),
                const SizedBox(width: 10),
                Text(
                  category.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            children: category.symptoms.map((symptom) {
              return _buildSymptomItem(symptom);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomItem(Symptom symptom) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.draft.symptoms.containsKey(symptom.label),
                onChanged: (val) {
                  setState(() {
                    symptom.selected = val ?? false;
                    if (val == true) {
                      widget.draft.symptoms[symptom.label] = {
                        "selected": true,
                        "extra": null,
                      };
                    } else {
                      widget.draft.symptoms.remove(symptom.label);
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  symptom.label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),

          if (widget.draft.symptoms.containsKey(symptom.label)) ...[
            if (symptom.label == "Batuk") ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildSmallSelectionButton(
                    currentValue: widget.draft.symptoms[symptom.label]?["type"] ?? "",
                    buttonValue: "Kering",
                    onSelected: (val) {
                      setState(() {
                        widget.draft.symptoms[symptom.label]!["type"] = val;
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildSmallSelectionButton(
                    currentValue: widget.draft.symptoms[symptom.label]?["type"] ?? "",
                    buttonValue: "Berkahak",
                    onSelected: (val) {
                      setState(() {
                        widget.draft.symptoms[symptom.label]!["type"] = val;
                      });
                    },
                  ),
                ],
              ),
            ],

            const SizedBox(height: 8),

            TextField(
              onChanged: (value) {
                widget.draft.symptoms[symptom.label]!["extra"] =
                int.tryParse(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "sejak berapa hari?",
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
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildSmallSelectionButton({
    required String currentValue,
    required String buttonValue,
    required Function(String) onSelected,
  }) {
    final isSelected = currentValue == buttonValue;

    return Expanded(
      child: OutlinedButton(
        onPressed: () => setState(() => onSelected(buttonValue)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          backgroundColor:
              isSelected ? Colors.blue.shade50 : Colors.white,
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonValue,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAdditionalNotesBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Catatan Tambahan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 5,
          onChanged: (value) {
            widget.draft.additionalNotes = value;
          },
          decoration: InputDecoration(
            hintText: "Masukkan catatan tambahan di sini...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCameraUploadBox() {
    final hasImage = widget.draft.imageBase64 != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gambar (Pilihan)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _showImageSourceSheet,
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: hasImage ? Colors.blue.shade300 : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
              color: hasImage ? Colors.blue.shade50 : Colors.grey.shade50,
            ),
            child: hasImage
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          base64Decode(widget.draft.imageBase64!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      // Remove button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => setState(() => widget.draft.imageBase64 = null),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      // Tap to change label
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Ketik untuk tukar gambar",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.grey, size: 40),
                      SizedBox(height: 8),
                      Text(
                        "Ambil atau muat naik gambar",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Berguna untuk ruam, luka, atau keadaan kulit",
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            // Only show camera on mobile — Windows doesn't support it
            if (!Platform.isWindows)
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Ambil Gambar (Kamera)"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text("Pilih dari Galeri"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (widget.draft.imageBase64 != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  "Buang Gambar",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => widget.draft.imageBase64 = null);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (picked == null) return;

      final bytes = await picked.readAsBytes();
      setState(() {
        widget.draft.imageBase64 = base64Encode(bytes);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tidak dapat memilih gambar: $e")),
      );
    }
  }


  // Widget _buildSymptomExtraField(Symptom symptom) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8),
  //     child: TextField(
  //       onChanged: (value) {
  //         symptom.extraValue = value; // backend ready
  //       },
  //       decoration: InputDecoration(
  //         hintText: "Sejak berapa hari",
  //         suffixText: "hari",
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //     // enabledBorder: OutlineInputBorder( 
  //     //   borderRadius: BorderRadius.circular(20),
  //     //   borderSide: BorderSide(color: Colors.grey.shade400),
  //     // ),
  //     // focusedBorder: OutlineInputBorder(
  //     //   borderRadius: BorderRadius.circular(20),
  //     //   borderSide: const BorderSide(color: Colors.blue),
  //     // ),
  //       ),
  //     ),
  //   );
  // }

}
