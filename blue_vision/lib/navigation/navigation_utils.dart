import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

String _getFullUrlFromRelative(
  BuildContext context,
  String location,
  Map<String, String> params,
  Map<String, dynamic> queryParams,
  bool addExistingQueryParams,
) {
  assert(
    !location.startsWith('/'),
    "Relative locations must not start with a '/'.",
  );

  final state = GoRouterState.of(context);
  final currentUrl = Uri.parse(state.location);

  String newPath = Uri(pathSegments: [currentUrl.path, location]).toString();

  for (final entry in params.entries) {
    newPath = newPath.replaceAll(':${entry.key}', entry.value);
  }

  final newUrl = currentUrl.replace(path: newPath, queryParameters: {
    if (addExistingQueryParams) ...currentUrl.queryParameters,
    ...queryParams,
  });

  return newUrl.toString();
}

String _getFullUrlFromLastPathUpdate(
  BuildContext context, {
  required String lastPath,
}) {
  final state = GoRouterState.of(context);
  final currentUrl = Uri.parse(state.location);
  final newPathSegments = [...currentUrl.pathSegments]
    ..removeLast()
    ..add(lastPath);

  final newUrl = currentUrl.replace(path: '/${newPathSegments.join("/")}');

  return newUrl.toString();
}

extension GoRouterHelper2 on BuildContext {
  void goParent({
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool addExistingQueryParams = false,
  }) {
    return goRelative(
      '../',
      params: params,
      queryParams: queryParams,
      extra: extra,
      addExistingQueryParams: addExistingQueryParams,
    );
  }

  void goRelative(
    String location, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
    bool addExistingQueryParams = true,
  }) {
    go(
      locationFromRelativePath(
        location,
        params: params,
        queryParams: queryParams,
        addExistingQueryParams: addExistingQueryParams,
      ),
      extra: extra,
    );
  }

  void replaceLastPath(String path) {
    go(
      _getFullUrlFromLastPathUpdate(
        this,
        lastPath: path,
      ),
    );
  }

  String locationFromRelativePath(
    String relativePath, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    bool addExistingQueryParams = true,
  }) {
    return _getFullUrlFromRelative(
        this, relativePath, params, queryParams, addExistingQueryParams);
  }
}
