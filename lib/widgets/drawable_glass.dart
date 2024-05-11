import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DraggableGlass extends StatelessWidget {
  const DraggableGlass({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: 'glass',
      feedback: Icon(
        MaterialCommunityIcons.glass_pint_outline,
        color: Colors.blue.withOpacity(0.7),
        size: 40,
      ),
      childWhenDragging: const Icon(
        MaterialCommunityIcons.glass_pint_outline,
        color: Colors.grey,
        size: 40,
      ),
      onDragEnd: (details) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Water drank!'),
            duration: Duration(seconds: 2),
          ),
        );
      }, // Data to send when the draggable is accepted by the target.
      child: const Icon(
        MaterialCommunityIcons
            .glass_pint_outline, // You can replace this with any appropriate glass icon.
        color: Colors.blue,
        size: 40,
      ),
    );
  }
}
