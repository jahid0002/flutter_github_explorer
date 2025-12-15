import 'package:intl/intl.dart';

class DateFormatter {
  // Prevent instantiation
  DateFormatter._();

  /// Format date to MM-dd-yyyy HH:mm format
  /// Example: 12-15-2024 14:30
  static String format(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy HH:mm').format(dateTime);
  }

  /// Format date to relative time
  /// Examples: "2 days ago", "3 hours ago", "Just now"
  static String formatRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Format date to readable format
  /// Example: December 15, 2024
  static String formatReadable(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  /// Format date to short format
  /// Example: Dec 15, 2024
  static String formatShort(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  /// Format time only
  /// Example: 14:30
  static String formatTimeOnly(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Format date and time with day
  /// Example: Monday, Dec 15, 2024 at 2:30 PM
  static String formatFull(DateTime dateTime) {
    return DateFormat('EEEE, MMM dd, yyyy \'at\' h:mm a').format(dateTime);
  }

  /// Format to ISO 8601 string
  /// Example: 2024-12-15T14:30:00.000
  static String formatIso(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  /// Parse ISO 8601 string to DateTime
  static DateTime? parseIso(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Get time ago in short format
  /// Examples: "2d", "3h", "5m", "now"
  static String formatShortRelative(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Format with today/yesterday support
  /// Examples: "Today at 2:30 PM", "Yesterday at 3:45 PM", "Dec 15 at 4:00 PM"
  static String formatSmart(DateTime dateTime) {
    if (isToday(dateTime)) {
      return 'Today at ${DateFormat('h:mm a').format(dateTime)}';
    } else if (isYesterday(dateTime)) {
      return 'Yesterday at ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return DateFormat('MMM dd \'at\' h:mm a').format(dateTime);
    }
  }
}
