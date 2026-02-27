// // Final report screen (green yellow or red)
// import 'package:flutter/material.dart';

// class TriageResultView extends StatelessWidget {
//   final String category; // "RINGAN", "SEDERHANA", "TERUK"

//   const TriageResultView({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     Color headerColor = category == "TERUK"
//         ? Colors.red.shade50
//         : Colors.green.shade50;
//     Color textColor = category == "TERUK"
//         ? Colors.red.shade900
//         : Colors.green.shade900;

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 120,
//             backgroundColor: headerColor,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(
//                 "Penilaian: $category",
//                 style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               _buildResultCard("Kemungkinan Keadaan", [
//                 _buildProbabilityItem(
//                   "Jangkitan Saluran Pernafasan (URTI)",
//                   0.85,
//                 ),
//                 _buildProbabilityItem("Pharyngitis", 0.15),
//               ]),
//               _buildActionCard(category),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultCard(String title, List<Widget> children) {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const Divider(),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProbabilityItem(String name, double value) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [Text(name), Text("${(value * 100).toInt()}%")],
//         ),
//         LinearProgressIndicator(
//           value: value,
//           backgroundColor: Colors.grey.shade200,
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   Widget _buildActionCard(String category) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: category == "TERUK" ? Colors.red : category == "SEDERHANA" ? Colors.yellow : Colors.green,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         category == "TERUK" ? "RUJUK SEGERA KE HOSPITAL" : "RAWAT DI KLINIK",
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

  
// }
