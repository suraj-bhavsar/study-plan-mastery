import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:study_plan_student_dashboard/app/constants.dart';

abstract class ToastHelper {
  // Show Success Toast
  static void showSuccess({
    String title = ToastTitles.success,
    required String message,
    VoidCallback? onTap,
  }) {
    _showToast(
      title: title,
      titleColor: AppColors.primary,
      subtitle: message,
      icon: Icons.check_circle_outline_rounded,
      onTap: onTap,
    );
  }

  // Show Warning Toast
  static void showWarning({
    String title = ToastTitles.warning,
    required String message,
    VoidCallback? onTap,
  }) {
    _showToast(
      title: title,
      titleColor: AppColors.yellow,
      subtitle: message,
      icon: Icons.warning_amber_rounded,
      onTap: onTap,
    );
  }

  // Show Error Toast
  static void showError({
    String title = ToastTitles.error,
    required String message,
    VoidCallback? onTap,
  }) {
    _showToast(
      title: title,
      titleColor: AppColors.red,
      subtitle: message,
      icon: Icons.error_outline_rounded,
      onTap: onTap,
    );
  }

  // Show Notification Toast
  static void showNotification({
    required String title,
    required String message,
    VoidCallback? onTap,
  }) {
    _showToast(
      title: title,
      titleColor: AppColors.primary,
      subtitle: message,
      icon: Icons.notifications_active_outlined,
      onTap: onTap,
    );
  }

  static void _showToast({
    required String title,
    required Color titleColor,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 3),
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: AppColors.toastBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: onTap,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: titleColor,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: titleColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.toastSubtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
