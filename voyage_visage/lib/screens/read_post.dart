import 'package:flutter/material.dart';

// class ReadPost extends StatelessWidget {
//   final String title;
//   final String description;

//   ReadPost({required this.title, required this.description});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(child: Text("Read Post")),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 description,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ReadPost screen
class ReadPost extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  ReadPost({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 150, // Adjust the height as needed
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
