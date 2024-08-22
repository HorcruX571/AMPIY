import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final Icon image;
  final String? buttonText;
  final VoidCallback? onPressed;

  SectionCard({
    required this.title,
    required this.description,
    required this.image,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              image,
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          if (buttonText != null) ...[
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText!),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 39, 0, 212)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
