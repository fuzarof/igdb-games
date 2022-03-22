import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:igdb_games/core/helpers/constants/constants.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/injection_container.dart';

export 'package:dio/dio.dart';

class IGDBCustomDio extends DioForNative {
  IGDBCustomDio()
      : super(
          BaseOptions(
            baseUrl: inject.get<IDotEnvHelper>().getValue(Constants().envConstants.baseUrl),
          ),
        );
}
