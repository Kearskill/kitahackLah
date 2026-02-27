// Step 2: Simptom Pesakit
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

final ImagePicker _picker = ImagePicker();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gambar (Pilihan)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickFromCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Imbas"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickFromGallery,
                      icon: const Icon(Icons.photo),
                      label: const Text("Galeri"),
                    ),
                  ),
                ],
              ),

              if (widget.draft.imageFiles.isNotEmpty) ...[
                const SizedBox(height: 16),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.draft.imageFiles.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final file =
                        widget.draft.imageFiles[index];

                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: Image.file(
                            file!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.draft.imageFiles
                                    .removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              padding:
                                  const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
  
  Future<void> _pickFromCamera() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        widget.draft.imageFiles.add(File(photo.path));
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final List<XFile>? images =
        await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        widget.draft.imageFiles
            .addAll(images.map((e) => File(e.path)));
      });
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
