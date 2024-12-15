import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  Color _getColor() {
    if (strength <= 0.2) return AppTheme.error;
    if (strength <= 0.4) return AppTheme.warning;
    if (strength <= 0.6) return AppTheme.warning;
    if (strength <= 0.8) return AppTheme.info;
    return AppTheme.success;
  }

  String _getLabel() {
    if (strength <= 0.2) return 'Very Weak';
    if (strength <= 0.4) return 'Weak';
    if (strength <= 0.6) return 'Medium';
    if (strength <= 0.8) return 'Strong';
    return 'Very Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          child: LinearProgressIndicator(
            value: strength,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(_getColor()),
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _getLabel(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _getColor(),
              ),
        ),
      ],
    );
  }
}
