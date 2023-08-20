import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/utils/target_platform_extended.dart';
import 'package:unplash_sample/dependency_injection.dart';

abstract class MixpanelConfig {
  void trackImageDetaislsEvent(String photoId);
  void trackLikeEventForExperimentation({
    required LikeButtonPosition likeButtonPosition,
    required String photoId,
  });
  void trackLikeVariant(LikeButtonPosition likeButtonPosition);
}

class MixpanelConfigImpl implements MixpanelConfig {
  final TargetPlatformExtended targetPlatformExtended;

  MixpanelConfigImpl(this.targetPlatformExtended);

  Mixpanel get mixpanel {
    return DependencyInjection.getIt<Mixpanel>();
  }

  @override
  void trackImageDetaislsEvent(String photoId) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track(
        "image-details",
        properties: {"photoId": photoId},
      );
    }
  }

  @override
  void trackLikeEventForExperimentation({
    required LikeButtonPosition likeButtonPosition,
    required String photoId,
  }) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track('like-experimentation', properties: {
        "variant": describeEnum(likeButtonPosition),
        "photoId": photoId,
      });
    }
  }

  @override
  void trackLikeVariant(LikeButtonPosition likeButtonPosition) {
    if (targetPlatformExtended.isMobile) {
      mixpanel.track('like-variant', properties: {
        "variant": describeEnum(likeButtonPosition),
      });
    }
  }
}
