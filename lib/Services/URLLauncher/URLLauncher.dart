import 'package:url_launcher/url_launcher.dart';

import '../../Helpers/ServiceResult/ServiceResult.dart';

class URLLauncher {
  Future<ServiceResult<bool>> launchIncomingUrl({required String url}) async {
    try {
      final Uri uriToOpen = Uri.parse(url);
      var data = await launchUrl(uriToOpen);
      return ServiceResult(
          statusCode: data ? StatusCode.accepted : StatusCode.notFound,
          data: data,
          message: "URL Launched");
    } catch (exception) {
      return ServiceResult(
          statusCode: StatusCode.expectationFailed,
          data: false,
          message: exception.toString());
    }
  }
}
