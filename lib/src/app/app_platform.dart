import 'package:flutter/foundation.dart';

import '../extensions/domain/extension_models.dart';

AppPlatform currentAppPlatform() {
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS => AppPlatform.ios,
    _ => AppPlatform.android,
  };
}
