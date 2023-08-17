import 'package:get_it/get_it.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:unplash_sample/core/analytics/mixpanel_config.dart';
import 'package:unplash_sample/core/config/unleash_config.dart';
import 'package:unplash_sample/core/utils/web_platform_resolver.dart';
import 'package:unplash_sample/features/home/presentation/bloc/unsplash_image_bloc.dart';
import 'package:unplash_sample/features/image_details/presentation/bloc/image_details_bloc.dart';

import 'core/mocks/mixpanel_config_mock.dart';
import 'core/mocks/mixpanel_mock.dart';
import 'core/mocks/unelash_conifg_mock.dart';
import 'core/mocks/web_platform_resolver_mock.dart';

class MockDependencyInjection {
  MockDependencyInjection._();

  static GetIt get getIt => GetIt.instance;

  static void initialize({
    UnsplashImageBloc? unsplashImageBloc,
    ImageDetailsBloc? imageDetailsBloc,
  }) {
    getIt.registerLazySingleton<Mixpanel>(() => MixpanelMock());
    getIt.registerLazySingleton<UnleashConfig>(() => UnleashConfigMock());
    getIt.registerLazySingleton<MixpanelConfig>(() => MixPanelConfigMock());
    getIt.registerLazySingleton<WebPlatformResolver>(
      () => WebPlatformResolverMock(),
    );
    
    if (unsplashImageBloc != null) {
      getIt.registerFactory<UnsplashImageBloc>(() => unsplashImageBloc);
    }
    if (imageDetailsBloc != null) {
      getIt.registerFactory<ImageDetailsBloc>(() => imageDetailsBloc);
    }
  }
}
