import 'dart:async';
import 'package:packagekit/packagekit.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Need package name(s)');
    return;
  }
  var packageNames = args;

  var client = PackageKitClient();
  await client.connect();

  var resolveTransaction = await client.createTransaction();
  var resolveCompleter = Completer();
  var packageIds = <PackageKitPackageId>[];
  resolveTransaction.events.listen((event) {
    if (event is PackageKitPackageEvent) {
      packageIds.add(event.packageId);
    } else if (event is PackageKitFinishedEvent) {
      resolveCompleter.complete();
    }
  });
  await resolveTransaction.resolve(packageNames);
  await resolveCompleter.future;
  if (packageIds.isEmpty) {
    print('No packages found');
    await client.close();
    return;
  }

  var getDetailsTransaction = await client.createTransaction();
  var getDetailsCompleter = Completer();
  getDetailsTransaction.events.listen((event) {
    if (event is PackageKitDetailsEvent) {
      print('Summary: ${event.summary}');
      print('Description: ${event.description}');
      print('Url: ${event.url}');
      print('License: ${event.license}');
      print('Size: ${event.size}');
    } else if (event is PackageKitFinishedEvent) {
      getDetailsCompleter.complete();
    }
  });
  await getDetailsTransaction.getDetails(packageIds);
  await getDetailsCompleter.future;

  await client.close();
}
