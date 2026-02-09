import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lanis/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

enum UrlModalResponse {
  /// The user opened the URL.
  opened,

  /// The user dismissed the modal.
  dismissed,

  /// The user opened the URL, but the URL could not be opened.
  rejected,
}

/// List of trusted domain endings. If a URL ends with one of these, it will be opened without asking the user.
///
/// As a school, you may make a pull request and add your domain to this list after verification.
const trustedDomains = [
  'lanis-mobile.alessioc42.dev',
  'hessen.de',
  'bund.de',
  'wikipedia.org',
  'gesetze-im-internet.de',
];

Future<UrlModalResponse> openUrlModal(BuildContext context, Uri uri) async {
  bool? open;

  if (trustedDomains.any((domain) => uri.host.endsWith(domain))) {
    open = true;
  } else {
    logger.w('Untrusted URL: $uri');
  }

  if (open == null || !open) {
    open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).openExternalUrl),
        content: Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Text(AppLocalizations.of(context).openExternalUrlDescription),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(4.0),
                child: Text(
                  uri.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: uri.toString()));
              Navigator.of(context).pop(false);
            },
            icon: Icon(Icons.copy),
            label: Text(AppLocalizations.of(context).copy),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  if (open == null || !open) {
    return UrlModalResponse.dismissed;
  }
  try {
    final response = await launchUrl(uri);

    if (!response) {
      logger.w('$uri konnte nicht geöffnet werden.');
      return UrlModalResponse.rejected;
    }

    return UrlModalResponse.opened;
  } catch (e, s) {
    logger.w('$uri konnte nicht geöffnet werden.');
    logger.e(e, stackTrace: s);
    return UrlModalResponse.rejected;
  }
}
