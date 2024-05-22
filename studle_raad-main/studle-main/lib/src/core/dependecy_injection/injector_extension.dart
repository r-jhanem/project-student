import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/authentication/data/services/auth_mock_service_impl.dart';
import '../../modules/authentication/domain/entities/user_entity.dart';
import '../../modules/authentication/domain/services/i_auth_service.dart';
import '../../modules/calendar/data/services/calendar_mock_service_impl.dart';
import '../../modules/calendar/domain/services/i_calendar_service.dart';
import '../../modules/notifications/data/services/notification_local_service_impl.dart';
import '../../modules/notifications/domain/services/i_notification_service.dart';
import '../constants/local_storage_key.dart';
import '../services/image_picker/data/services/image_picker_service_impl.dart';
import '../services/image_picker/domain/services/i_image_picker_service.dart';
import '../services/local_storage/data/services/local_storage_shared_preferences_service_impl.dart';
import '../services/local_storage/domain/services/i_local_storage_service.dart';
import '../user_session.dart';
import 'injector.dart';

extension InjectorExtension on GetIt {
  GetIt registerAuthenticationServices() {
    return this
      ..registerLazySingleton<IAuthService>(
        () => AuthMockServiceImpl(),
      );
  }

  GetIt registerCalendarServices() {
    return this
      ..registerLazySingleton<ICalendarService>(
        () => CalendarMockServiceImpl(),
      );
  }

  GetIt registerImagePickerService() {
    return this
      ..registerLazySingleton<IImagePickerService>(
        () => ImagePickerServiceImpl(),
      );
  }

  GetIt registerLocalStorageServices() {
    return this
      ..registerSingletonAsync<ILocalStorageService>(
        () async => LocalStorageSharedPreferencesServiceImpl(
          sharedPreferences: await SharedPreferences.getInstance(),
        ),
      );
  }

  GetIt registerUserSession() {
    return this
      ..registerSingletonAsync<UserSession>(
        () async {
          final localStorage = Injector.resolve<ILocalStorageService>();

          final firstAccess =
              (await localStorage.read<bool>(LocalStorageKey.firstAccess))
                      .getOrNull() ??
                  true;

          final userJson =
              (await localStorage.read<String>(LocalStorageKey.user))
                  .getOrNull();

          UserEntity? user;

          if (userJson != null) {
            try {
              user = UserEntity.fromJson(userJson);
            } catch (e) {
              await localStorage.delete(LocalStorageKey.user);
            }
          }

          return UserSession(
            user: user,
            firstAccess: firstAccess,
            localStorageService: Injector.resolve(),
          );
        },
        dependsOn: [
          ILocalStorageService,
        ],
      );
  }

  GetIt registerNotificationServices() {
    return this
      ..registerLazySingleton<INotificationService>(
        () => NotificationLocalServiceImpl(
          localStorageService: Injector.resolve(),
        ),
      );
  }
}
