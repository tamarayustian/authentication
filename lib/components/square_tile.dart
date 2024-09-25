import 'package:flutter/material.dart';

class SquareTile extends StatefulWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({super.key, required this.imagePath, required this.onTap});

  @override
  _SquareTileState createState() => _SquareTileState();
}

class _SquareTileState extends State<SquareTile> {
  bool _isHovered = false; // Track the hover state

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: _isHovered
                ? Colors.grey[300]
                : Colors.grey[200], // Change color on hover
          ),
          child: Image.asset(
            widget.imagePath,
            height: 72,
          ),
        ),
      ),
    );
  }
}
