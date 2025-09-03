import 'package:flutter/material.dart';

/// HackNova Design System Widgets
/// All widgets below support dark/light themes and accessibility.

/// Primary Button
class FFPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final bool fullWidth;

  const FFPrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.icon,
    this.fullWidth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        icon: loading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                ),
              )
            : (icon != null ? Icon(icon, size: 18) : const SizedBox.shrink()),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: loading ? null : onPressed,
      ),
    );
  }
}

/// Card Container
class FFCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double elevation;

  const FFCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: color ?? theme.colorScheme.surface,
      elevation: elevation,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

/// Section Title
class FFSectionTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;

  const FFSectionTitle({
    Key? key,
    required this.text,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (icon != null)
          Icon(icon, color: color ?? theme.colorScheme.primary, size: 22),
        if (icon != null) const SizedBox(width: 8),
        Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: color ?? theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Themed Container (for backgrounds, sections)
class FFThemedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const FFThemedContainer({
    Key? key,
    required this.child,
    this.color,
    this.borderRadius = 12,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.background,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}

/// Accessibility: Large Type Toggle
class FFLargeTypeToggle extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const FFLargeTypeToggle({
    Key? key,
    required this.enabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.text_fields),
        const SizedBox(width: 8),
        Text('Large Type'),
        Switch(
          value: enabled,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
