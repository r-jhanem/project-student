import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../utils/redirect_to_url.dart';
import '../../design_system/design_system.dart';

class ErrorStateDisplay extends StatelessWidget {
  const ErrorStateDisplay({
    super.key,
    this.icon = PhosphorIconsRegular.warningCircle,
    this.title = 'Algo deu errado',
    required this.description,
    this.primaryButtonText,
    this.onPressedPrimaryButton,
    this.secondaryButtonText = 'Falar com o suporte',
    this.onPressedSecondaryButton,
  });
  final IconData icon;
  final String title;
  final String description;
  final String? primaryButtonText;
  final VoidCallback? onPressedPrimaryButton;
  final String? secondaryButtonText;
  final VoidCallback? onPressedSecondaryButton;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: 1000.ms,
        ),
        ScaleEffect(
          begin: const Offset(0.98, 0.98),
          alignment: Alignment.center,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: 1000.ms,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: SemanticColors.negative,
            size: 80,
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: Heading2Typography(
              fontWeight: FontWeight.w600,
              color: MonoChromaticColors.gray.v900,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: Text2Typography(
              color: MonoChromaticColors.gray,
            ),
          ),
          if (primaryButtonText != null || secondaryButtonText != null)
            const SizedBox(height: 40),
          if (primaryButtonText != null)
            SolidButton.negative(
              label: primaryButtonText!,
              onPressed: onPressedPrimaryButton,
            ),
          if (secondaryButtonText != null) ...[
            const SizedBox(height: 16),
            SolidButton.outlined(
              label: secondaryButtonText!,
              onPressed: onPressedSecondaryButton ??
                  () {
                    redirectToUrl(
                      'https://github.com/bernardoveras/studle/discussions/new/choose',
                    );
                  },
            ),
          ],
        ],
      ),
    );
  }
}
