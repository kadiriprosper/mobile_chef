import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomRecipeFilterChip extends StatelessWidget {
  const CustomRecipeFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.leading,
    required this.onTap,
    required this.isLoading, required this.widgetKey,
  });

  final String label;
  final bool selected;
  final Widget leading;
  final bool isLoading;
  final GlobalKey widgetKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: widgetKey,
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? Colors.black : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            isLoading
                ? const SpinKitFadingCube(
                    color: Colors.white,
                    size: 11,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
    // FilterChip(
    //   label: Text(label),
    //   padding: const EdgeInsets.all(14),
    //   avatar: leading,
    //   selected: selected,
    //   selectedColor: Colors.orange.shade800,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     side: BorderSide.none,
    //   ),
    //   showCheckmark: false,
    //   onSelected: (_) => onTap,
    // );
  }
}
