// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/core/theme/app_colors.dart';
import 'package:flutter_github_explorer/core/utils/constants.dart';

class SortButton extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SortButton({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight
            .withAlpha(50), //colorScheme.onPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          icon: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.sort,
              color: AppColors.surfaceLight,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          color: colorScheme.surface,
          onSelected: onSortChanged,
          itemBuilder: (context) => [
            _buildMenuItem(
              context,
              value: Constants.sortByStars,
              icon: Icons.star,
              label: 'Sort by Stars',
              isSelected: currentSort == Constants.sortByStars,
              color: Colors.amber,
            ),
            _buildMenuItem(
              context,
              value: Constants.sortByUpdated,
              icon: Icons.update,
              label: 'Sort by Updated',
              isSelected: currentSort == Constants.sortByUpdated,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    BuildContext context, {
    required String value,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopupMenuItem(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    color.withOpacity(0.18),
                    color.withOpacity(0.08),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? color : colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : colorScheme.onSurface,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
