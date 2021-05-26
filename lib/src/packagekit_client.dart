import 'dart:async';

import 'package:dbus/dbus.dart';

/// D-Bus interface names.
const _packageKitBusName = 'org.freedesktop.PackageKit';
const _packageKitInterfaceName = 'org.freedesktop.PackageKit';
const _packageKitTransactionInterfaceName =
    'org.freedesktop.PackageKit.Transaction';

enum PackageKitDistroUpgrade { unknown, stable, unstable }

enum PackageKitError {
  unknown,
  outOfMemory,
  noNetwork,
  notSupported,
  internalError,
  gpgFailure,
  packageIdInvalid,
  packageNotInstalled,
  packageNotFound,
  packageAlreadyInstalled,
  packageDownloadFailed,
  groupNotFound,
  groupListInvalid,
  dependencyResolutionFailed,
  filterInvalid,
  createThreadFailed,
  transactionError,
  transactionCancelled,
  noCache,
  repositoryNotFound,
  cannotRemoveSystemPackage,
  processKill,
  failedInitialization,
  failedFinalize,
  failedConfigParsing,
  cannotCancel,
  cannotGetLock,
  noPackagesToUpdate,
  cannotWriteRepositoryConfig,
  localInstallFailed,
  badGpgSignature,
  missingGpgSignature,
  cannotInstallSourcePackage,
  repositoryConfigurationError,
  noLicenseAgreement,
  fileConflicts,
  packageConflicts,
  repositoryNotAvailable,
  invalidPackageFile,
  packageInstallBlocked,
  packageCorrupt,
  allPackagesAlreadyInstalled,
  fileNotFound,
  noMoreMirrorsToTry,
  noDistroUpgradeData,
  incompatibleArchitecture,
  noSpaceOnDevice,
  mediaChangeRequired,
  notAuthorized,
  updateNotFound,
  cannotInstallRepositoryUnsigned,
  cannotUpdateRepositoryUnsigned,
  cannotGetFileList,
  cannotGetRequires,
  cannotDisableRepository,
  restrictedDownload,
  packageFailedToConfigure,
  packageFailedToBuild,
  packageFailedToInstall,
  packageFailedToRemove,
  updateFailedDueToRunningProcess,
  packageDatabaseChanged,
  provideTypeNotSupported,
  installRootInvalid,
  cannotFetchSources,
  cancelledPriority,
  unfinishedTransaction,
  lockRequired,
  repositoryAlreadySet
}

enum PackageKitExit {
  unknown,
  success,
  failed,
  cancelled,
  keyRequired,
  eulaRequired,
  killed,
  mediaChangeRequired,
  needUntrusted,
  cancelledPriority,
  skipTransaction,
  repairRequired
}

enum PackageKitFilter {
  unknown,
  none,
  installed,
  notInstalled,
  development,
  notDevelopment,
  gui,
  notGui,
  free,
  notFree,
  visible,
  notVisible,
  supported,
  notSupported,
  baseName,
  notBaseName,
  newest,
  notNewest,
  arch,
  notArch,
  source,
  notSource,
  collections,
  notCollections,
  application,
  notApplication,
  downloaded,
  notDownloaded
}

Set<PackageKitFilter> _decodeFilters(int mask) {
  var filters = <PackageKitFilter>{};
  for (var value in PackageKitFilter.values) {
    if ((mask & (1 << value.index)) != 0) {
      filters.add(value);
    }
  }
  return filters;
}

int _encodeFilters(Set<PackageKitFilter> filter) {
  var value = 0;
  for (var f in filter) {
    value |= 1 << f.index;
  }
  return value;
}

enum PackageKitGroup {
  unknown,
  accessibility,
  accessories,
  adminTools,
  communication,
  desktopGnome,
  desktopKde,
  desktopOther,
  desktopXfce,
  education,
  fonts,
  games,
  graphics,
  internet,
  legacy,
  localization,
  maps,
  multimedia,
  network,
  office,
  other,
  powerManagement,
  programming,
  publishing,
  repos,
  security,
  servers,
  system,
  virtualization,
  science,
  documentation,
  electronics,
  collections,
  vendor,
  newest
}

Set<PackageKitGroup> _decodeGroups(int mask) {
  var groups = <PackageKitGroup>{};
  for (var value in PackageKitGroup.values) {
    if ((mask & (1 << value.index)) != 0) {
      groups.add(value);
    }
  }
  return groups;
}

enum PackageKitInfo {
  unknown,
  installed,
  available,
  low,
  enhancement,
  normal,
  bugfix,
  important,
  security,
  blocked,
  downloading,
  updating,
  installing,
  removing,
  cleanup,
  obsoleting,
  collectionInstalled,
  collectionAvailable,
  finished,
  reinstalling,
  downgrading,
  preparing,
  decompressing,
  untrusted,
  trusted,
  unavailable
}

enum PackageKitMediaType { unknown, cd, dvd, disc }

enum PackageKitNetworkState { unknown, offline, online, wired, wifi, mobile }

enum PackageKitRole {
  unknown,
  cancel,
  dependsOn,
  getDetails,
  getFiles,
  getPackages,
  getRepositoryList,
  requiredBy,
  getUpdateDetail,
  getUpdates,
  installFiles,
  installPackages,
  installSignature,
  refreshCache,
  removePackages,
  repoEnable,
  repoSetData,
  resolve,
  searchDetails,
  searchFile,
  searchGroup,
  searchName,
  updatePackages,
  whatProvides,
  acceptEula,
  downloadPackages,
  getDistroUpgrades,
  getCategories,
  getOldTransactions,
  repairSystem,
  getDetailsLocal,
  getFilesLocal,
  repoRemove,
  upgradeSystem
}

Set<PackageKitRole> _decodeRoles(int mask) {
  var roles = <PackageKitRole>{};
  for (var value in PackageKitRole.values) {
    if ((mask & (1 << value.index)) != 0) {
      roles.add(value);
    }
  }
  return roles;
}

enum PackageKitRestart {
  unknown,
  none,
  application,
  session,
  system,
  securitySession,
  securitySystem
}

enum PackageKitSignatureType { unknown, gpg }

enum PackageKitStatus {
  unknown,
  wait,
  setup,
  running,
  query,
  info,
  remove,
  refreshCache,
  download,
  install,
  update,
  cleanup,
  obsolete,
  dependencyResolve,
  signatureCheck,
  testCommit,
  commit,
  request,
  finished,
  cancel,
  downloadRepository,
  downloadPackageList,
  downloadFileList,
  downloadChangelog,
  downloadGroup,
  downloadUpdateInfo,
  repackaging,
  loadingCache,
  scanApplications,
  generatePackageList,
  waitingForLock,
  waitingForAuth,
  scanProcessList,
  checkExecutableFiles,
  checkLibraries,
  copyFiles,
  runHook
}

enum PackageKitTransactionFlag {
  onlyTrusted,
  simulate,
  onlyDownload,
  allowReinstall,
  justReinstall,
  allowDowngrade
}

int _encodeTransactionFlags(Set<PackageKitTransactionFlag> flags) {
  var value = 0;
  for (var f in flags) {
    value |= 1 << f.index;
  }
  return value;
}

enum PackageKitUpdateState { unknown, stable, unstable, testing }

class PackageKitPackageId {
  final String name;
  final String version;
  final String arch;
  final String data;

  const PackageKitPackageId(
      {required this.name,
      required this.version,
      this.arch = '',
      this.data = ''});

  factory PackageKitPackageId.fromString(String value) {
    var tokens = value.split(';');
    if (tokens.length != 4) {
      throw FormatException('Invalid number of components in Package ID');
    }

    return PackageKitPackageId(
        name: tokens[0], version: tokens[1], arch: tokens[2], data: tokens[3]);
  }

  @override
  bool operator ==(other) =>
      other is PackageKitPackageId &&
      other.name == name &&
      other.version == version &&
      other.arch == arch &&
      other.data == data;

  @override
  String toString() {
    return '$name;$version;$arch;$data';
  }
}

class PackageKitEvent {
  const PackageKitEvent();
}

class PackageKitUnknownEvent extends PackageKitEvent {
  final String name;
  final List<DBusValue> values;

  PackageKitUnknownEvent(this.name, this.values);

  @override
  String toString() => "$runtimeType('$name', $values)";
}

class PackageKitCategoryEvent extends PackageKitEvent {
  final String parentId;
  final String catId;
  final String name;
  final String summary;
  final String icon;

  const PackageKitCategoryEvent(
      {required this.parentId,
      required this.catId,
      required this.name,
      required this.summary,
      required this.icon});

  @override
  String toString() =>
      "$runtimeType(parentId: '$parentId', catId: '$catId', name: '$name', summary: '$summary', icon: '$icon')";
}

class PackageKitDestroyEvent extends PackageKitEvent {
  const PackageKitDestroyEvent();

  @override
  String toString() => '$runtimeType()';
}

class PackageKitDetailsEvent extends PackageKitEvent {
  final Map<String, DBusValue> data;

  String? get description => data.containsKey('description')
      ? (data['description'] as DBusString).value
      : null;
  String? get license => data.containsKey('license')
      ? (data['license'] as DBusString).value
      : null;
  int? get size =>
      data.containsKey('size') ? (data['size'] as DBusUint64).value : null;
  String? get summary => data.containsKey('summary')
      ? (data['summary'] as DBusString).value
      : null;
  String? get url =>
      data.containsKey('url') ? (data['url'] as DBusString).value : null;

  const PackageKitDetailsEvent(this.data);

  @override
  String toString() => '$runtimeType($data)';
}

class PackageKitDistroUpgradeEvent extends PackageKitEvent {
  final PackageKitDistroUpgrade type;
  final String name;
  final String summary;

  const PackageKitDistroUpgradeEvent(
      {required this.type, required this.name, required this.summary});
  @override
  String toString() =>
      "$runtimeType(type: $type, name: '$name', summary: '$summary')";
}

class PackageKitFilesEvent extends PackageKitEvent {
  final PackageKitPackageId packageId;
  final List<String> fileList;

  PackageKitFilesEvent({required this.packageId, required this.fileList});

  @override
  bool operator ==(other) =>
      other is PackageKitFilesEvent &&
      other.packageId == packageId &&
      _listsEqual(other.fileList, fileList);

  @override
  String toString() =>
      "$runtimeType(packageId: '$packageId', fileList: $fileList)";
}

class PackageKitErrorCodeEvent extends PackageKitEvent {
  final PackageKitError code;
  final String details;

  const PackageKitErrorCodeEvent({required this.code, required this.details});

  @override
  bool operator ==(other) =>
      other is PackageKitErrorCodeEvent &&
      other.code == code &&
      other.details == details;

  @override
  String toString() => "$runtimeType(code: $code, details: '$details')";
}

class PackageKitEulaRequiredEvent extends PackageKitEvent {
  final String eulaId;
  final PackageKitPackageId packageId;
  final String vendorName;
  final String licenseAgreement;

  const PackageKitEulaRequiredEvent(
      {required this.eulaId,
      required this.packageId,
      required this.vendorName,
      required this.licenseAgreement});

  @override
  String toString() =>
      "$runtimeType(eulaId: '$eulaId', packageId: '$packageId', vendorName: '$vendorName', licenseAgreement: '$licenseAgreement')";
}

class PackageKitFinishedEvent extends PackageKitEvent {
  final PackageKitExit exit;
  final int runtime;

  const PackageKitFinishedEvent({required this.exit, required this.runtime});

  @override
  bool operator ==(other) =>
      other is PackageKitFinishedEvent &&
      other.exit == exit &&
      other.runtime == runtime;

  @override
  String toString() => '$runtimeType(exit: $exit, runtime: $runtime)';
}

class PackageKitItemProgressEvent extends PackageKitEvent {
  final PackageKitPackageId packageId;
  final PackageKitStatus status;
  final int percentage;

  const PackageKitItemProgressEvent(
      {required this.packageId,
      required this.status,
      required this.percentage});

  @override
  bool operator ==(other) =>
      other is PackageKitItemProgressEvent &&
      other.packageId == packageId &&
      other.status == status &&
      other.percentage == percentage;

  @override
  String toString() =>
      "PackageKitItemProgressEvent(packageId: '$packageId', status: $status, percentage: $percentage)";
}

class PackageKitMediaChangeRequiredEvent extends PackageKitEvent {
  final PackageKitMediaType mediaType;
  final String mediaId;
  final String mediaText;

  const PackageKitMediaChangeRequiredEvent(
      {required this.mediaType,
      required this.mediaId,
      required this.mediaText});

  @override
  bool operator ==(other) =>
      other is PackageKitMediaChangeRequiredEvent &&
      other.mediaType == mediaType &&
      other.mediaId == mediaId &&
      other.mediaText == mediaText;

  @override
  String toString() =>
      "PackageKitMediaChangeRequiredEvent(mediaType: $mediaType, mediaId: '$mediaId', mediaText: '$mediaText')";
}

class PackageKitPackageEvent extends PackageKitEvent {
  final PackageKitInfo info;
  final PackageKitPackageId packageId;
  final String summary;

  const PackageKitPackageEvent(
      {required this.info, required this.packageId, required this.summary});

  @override
  bool operator ==(other) =>
      other is PackageKitPackageEvent &&
      other.info == info &&
      other.packageId == packageId &&
      other.summary == summary;

  @override
  String toString() =>
      "$runtimeType(info: $info, packageId: '$packageId', summary: '$summary')";
}

class PackageKitRepositoryDetailEvent extends PackageKitEvent {
  final String repoId;
  final String description;
  final bool enabled;

  const PackageKitRepositoryDetailEvent(
      {required this.repoId, required this.description, required this.enabled});

  @override
  bool operator ==(other) =>
      other is PackageKitRepositoryDetailEvent &&
      other.repoId == repoId &&
      other.description == description &&
      other.enabled == enabled;

  @override
  String toString() =>
      "$runtimeType(repoId: '$repoId', description: '$description', enabled: $enabled)";
}

class PackageKitRepositorySignatureRequiredEvent extends PackageKitEvent {
  final PackageKitPackageId packageId;
  final String repositoryName;
  final String keyUrl;
  final String keyUserId;
  final String keyId;
  final String keyFingerprint;
  final String keyTimestamp;
  final PackageKitSignatureType type;

  const PackageKitRepositorySignatureRequiredEvent({
    required this.packageId,
    required this.repositoryName,
    required this.keyUrl,
    required this.keyUserId,
    required this.keyId,
    required this.keyFingerprint,
    required this.keyTimestamp,
    required this.type,
  });

  @override
  String toString() =>
      "$runtimeType(packageId: '$packageId', repositoryName: '$repositoryName', keyUrl: '$keyUrl', keyUserId: '$keyUserId', keyId: '$keyId', keyFingerprint: '$keyFingerprint', keyTimestamp: '$keyTimestamp', type: $type)";
}

class PackageKitRequireRestartEvent extends PackageKitEvent {
  final PackageKitRestart type;
  final PackageKitPackageId packageId;

  const PackageKitRequireRestartEvent(
      {required this.type, required this.packageId});

  @override
  bool operator ==(other) =>
      other is PackageKitRequireRestartEvent &&
      other.type == type &&
      other.packageId == packageId;

  @override
  String toString() => "$runtimeType(type: $type, packageId: '$packageId')";
}

class PackageKitTransactionEvent extends PackageKitEvent {
  final DBusObjectPath objectPath;
  final String timespec;
  final bool succeeded;
  final PackageKitRole role;
  final int duration;
  final String data;
  final int uid;
  final String cmdline;

  const PackageKitTransactionEvent(
      {required this.objectPath,
      required this.timespec,
      required this.succeeded,
      required this.role,
      required this.duration,
      required this.data,
      required this.uid,
      required this.cmdline});

  @override
  String toString() =>
      "$runtimeType(objectPath: $objectPath, timespec: '$timespec', succeeded: $succeeded, role: $role, duration: $duration, data: '$data', uid: $uid, cmdline: '$cmdline')";
}

class PackageKitUpdateDetailEvent extends PackageKitEvent {
  final PackageKitPackageId packageId;
  final List<String> updates;
  final List<String> obsoletes;
  final List<String> vendorUrls;
  final List<String> bugzillaUrls;
  final List<String> cveUrls;
  final PackageKitRestart restart;
  final String updateText;
  final String changelog;
  final PackageKitUpdateState state;
  final String issued;
  final String updated;

  const PackageKitUpdateDetailEvent(
      {required this.packageId,
      required this.updates,
      required this.obsoletes,
      required this.vendorUrls,
      required this.bugzillaUrls,
      required this.cveUrls,
      required this.restart,
      required this.updateText,
      required this.changelog,
      required this.state,
      required this.issued,
      required this.updated});

  @override
  String toString() =>
      "$runtimeType(packageId: '$packageId', updates: $updates, obsoletes: $obsoletes, vendorUrls: $vendorUrls, bugzillaUrls: $bugzillaUrls, cveUrls: $cveUrls, restart: $restart, updateText: '$updateText', changelog: '$changelog', state: $state, issued: '$issued', updated: '$updated')";
}

/// A PackageKit transaction.
class PackageKitTransaction {
  /// Remote transaction object.
  final DBusRemoteObject _object;

  late final Stream<PackageKitEvent> events;

  PackageKitTransaction(DBusClient bus, DBusObjectPath objectPath)
      : _object = DBusRemoteObject(bus, _packageKitBusName, objectPath) {
    events = DBusSignalStream(bus,
            sender: _packageKitBusName,
            interface: _packageKitTransactionInterfaceName,
            path: objectPath)
        .map((signal) {
      switch (signal.name) {
        case 'Category':
          if (signal.signature != DBusSignature('sssss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitCategoryEvent(
              parentId: (signal.values[0] as DBusString).value,
              catId: (signal.values[1] as DBusString).value,
              name: (signal.values[2] as DBusString).value,
              summary: (signal.values[3] as DBusString).value,
              icon: (signal.values[4] as DBusString).value);
        case 'Destroy':
          if (signal.signature != DBusSignature('')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitDestroyEvent();
        case 'Details':
          if (signal.signature != DBusSignature('a{sv}')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitDetailsEvent((signal.values[0] as DBusDict)
              .children
              .map((key, value) => MapEntry(
                  (key as DBusString).value, (value as DBusVariant).value)));
        case 'DistroUpgrade':
          if (signal.signature != DBusSignature('uss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitDistroUpgradeEvent(
              type: PackageKitDistroUpgrade
                  .values[(signal.values[0] as DBusUint32).value],
              name: (signal.values[1] as DBusString).value,
              summary: (signal.values[2] as DBusString).value);
        case 'ErrorCode':
          if (signal.signature != DBusSignature('us')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitErrorCodeEvent(
              code: PackageKitError
                  .values[(signal.values[0] as DBusUint32).value],
              details: (signal.values[1] as DBusString).value);
        case 'EulaRequired':
          if (signal.signature != DBusSignature('ssss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitEulaRequiredEvent(
              eulaId: (signal.values[0] as DBusString).value,
              packageId: PackageKitPackageId.fromString(
                  (signal.values[1] as DBusString).value),
              vendorName: (signal.values[2] as DBusString).value,
              licenseAgreement: (signal.values[3] as DBusString).value);
        case 'Files':
          if (signal.signature != DBusSignature('sas')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitFilesEvent(
              packageId: PackageKitPackageId.fromString(
                  (signal.values[0] as DBusString).value),
              fileList: (signal.values[1] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList());
        case 'Finished':
          if (signal.signature != DBusSignature('uu')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitFinishedEvent(
              exit:
                  PackageKitExit.values[(signal.values[0] as DBusUint32).value],
              runtime: (signal.values[1] as DBusUint32).value);
        case 'ItemProgress':
          if (signal.signature != DBusSignature('suu')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitItemProgressEvent(
              packageId: PackageKitPackageId.fromString(
                  (signal.values[0] as DBusString).value),
              status: PackageKitStatus
                  .values[(signal.values[1] as DBusUint32).value],
              percentage: (signal.values[2] as DBusUint32).value);
        case 'MediaChangeRequired':
          if (signal.signature != DBusSignature('uss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitMediaChangeRequiredEvent(
              mediaType: PackageKitMediaType
                  .values[(signal.values[0] as DBusUint32).value],
              mediaId: (signal.values[1] as DBusString).value,
              mediaText: (signal.values[2] as DBusString).value);
        case 'Package':
          if (signal.signature != DBusSignature('uss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitPackageEvent(
              info:
                  PackageKitInfo.values[(signal.values[0] as DBusUint32).value],
              packageId: PackageKitPackageId.fromString(
                  (signal.values[1] as DBusString).value),
              summary: (signal.values[2] as DBusString).value);
        case 'RepoDetail':
          if (signal.signature != DBusSignature('ssb')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitRepositoryDetailEvent(
              repoId: (signal.values[0] as DBusString).value,
              description: (signal.values[1] as DBusString).value,
              enabled: (signal.values[2] as DBusBoolean).value);
        case 'RepoSignatureRequired':
          if (signal.signature != DBusSignature('sssssssu')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitRepositorySignatureRequiredEvent(
              packageId: PackageKitPackageId.fromString(
                  (signal.values[0] as DBusString).value),
              repositoryName: (signal.values[1] as DBusString).value,
              keyUrl: (signal.values[2] as DBusString).value,
              keyUserId: (signal.values[3] as DBusString).value,
              keyId: (signal.values[4] as DBusString).value,
              keyFingerprint: (signal.values[5] as DBusString).value,
              keyTimestamp: (signal.values[6] as DBusString).value,
              type: PackageKitSignatureType
                  .values[(signal.values[7] as DBusUint32).value]);
        case 'RequireRestart':
          if (signal.signature != DBusSignature('us')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitRequireRestartEvent(
              type: PackageKitRestart
                  .values[(signal.values[0] as DBusUint32).value],
              packageId: PackageKitPackageId.fromString(
                  (signal.values[1] as DBusString).value));
        case 'Transaction':
          if (signal.signature != DBusSignature('osbuusus')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitTransactionEvent(
              objectPath: signal.values[0] as DBusObjectPath,
              timespec: (signal.values[1] as DBusString).value,
              succeeded: (signal.values[2] as DBusBoolean).value,
              role:
                  PackageKitRole.values[(signal.values[3] as DBusUint32).value],
              duration: (signal.values[4] as DBusUint32).value,
              data: (signal.values[5] as DBusString).value,
              uid: (signal.values[6] as DBusUint32).value,
              cmdline: (signal.values[7] as DBusString).value);
        case 'UpdateDetail':
          if (signal.signature != DBusSignature('sasasasasasussuss')) {
            throw 'Invalid ${signal.name} signal';
          }
          return PackageKitUpdateDetailEvent(
              packageId: PackageKitPackageId.fromString(
                  (signal.values[0] as DBusString).value),
              updates: (signal.values[1] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList(),
              obsoletes: (signal.values[2] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList(),
              vendorUrls: (signal.values[3] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList(),
              bugzillaUrls: (signal.values[4] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList(),
              cveUrls: (signal.values[5] as DBusArray)
                  .children
                  .map((value) => (value as DBusString).value)
                  .toList(),
              restart: PackageKitRestart
                  .values[(signal.values[6] as DBusUint32).value],
              updateText: (signal.values[7] as DBusString).value,
              changelog: (signal.values[8] as DBusString).value,
              state: PackageKitUpdateState
                  .values[(signal.values[9] as DBusUint32).value],
              issued: (signal.values[10] as DBusString).value,
              updated: (signal.values[11] as DBusString).value);
        default:
          return PackageKitUnknownEvent(signal.name, signal.values);
      }
    });
  }

  Future<void> acceptEula(String eulaId) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName, 'AcceptEula', [DBusString(eulaId)],
        replySignature: DBusSignature(''));
  }

  Future<void> cancel() async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'Cancel', [],
        replySignature: DBusSignature(''));
  }

  Future<void> dependsOn(Iterable<PackageKitPackageId> packageIds,
      {Set<PackageKitFilter> filter = const {}, bool recursive = false}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'DependsOn',
        [
          DBusUint64(_encodeFilters(filter)),
          DBusArray.string(packageIds.map((id) => id.toString())),
          DBusBoolean(recursive)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> downloadPackages(Iterable<PackageKitPackageId> packageIds,
      {bool storeInCache = false}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'DownloadPackages',
        [
          DBusBoolean(storeInCache),
          DBusArray.string(packageIds.map((id) => id.toString()))
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> getCategories() async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName, 'GetCategories', [],
        replySignature: DBusSignature(''));
  }

  Future<void> getDetails(Iterable<PackageKitPackageId> packageIds) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'GetDetails',
        [DBusArray.string(packageIds.map((id) => id.toString()))],
        replySignature: DBusSignature(''));
  }

  Future<void> getDetailsLocal(Iterable<String> files) async {
    await _object.callMethod(_packageKitTransactionInterfaceName,
        'GetDetailsLocal', [DBusArray.string(files)],
        replySignature: DBusSignature(''));
  }

  Future<void> getDistroUpgrades() async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName, 'GetDistroUpgrades', [],
        replySignature: DBusSignature(''));
  }

  Future<void> getFiles(Iterable<PackageKitPackageId> packageIds) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'GetFiles',
        [DBusArray.string(packageIds.map((id) => id.toString()))],
        replySignature: DBusSignature(''));
  }

  Future<void> getFilesLocal(Iterable<String> files) async {
    await _object.callMethod(_packageKitTransactionInterfaceName,
        'GetFilesLocal', [DBusArray.string(files)],
        replySignature: DBusSignature(''));
  }

  Future<void> getOldTransactions(int number) async {
    await _object.callMethod(_packageKitTransactionInterfaceName,
        'GetOldTransactions', [DBusUint32(number)],
        replySignature: DBusSignature(''));
  }

  Future<void> getPackages({Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'GetPackages',
        [DBusUint64(_encodeFilters(filter))],
        replySignature: DBusSignature(''));
  }

  Future<void> getRepositoryList(
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'GetRepoList',
        [DBusUint64(_encodeFilters(filter))],
        replySignature: DBusSignature(''));
  }

  Future<void> getUpdateDetail(Iterable<PackageKitPackageId> packageIds) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'GetUpdateDetail',
        [DBusArray.string(packageIds.map((id) => id.toString()))],
        replySignature: DBusSignature(''));
  }

  Future<void> getUpdates({Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'GetUpdates',
        [DBusUint64(_encodeFilters(filter))],
        replySignature: DBusSignature(''));
  }

  Future<void> installFiles(Iterable<String> fullPaths,
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'InstallFiles',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusArray.string(fullPaths)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> installPackages(Iterable<PackageKitPackageId> packageIds,
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'InstallPackages',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusArray.string(packageIds.map((id) => id.toString()))
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> installSignature(
      int signatureType, String keyId, PackageKitPackageId packageId) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'InstallSignature',
        [
          DBusUint32(signatureType),
          DBusString(keyId),
          DBusString(packageId.toString())
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> refreshCache({bool force = false}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName,
        'RefreshCache', [DBusBoolean(force)],
        replySignature: DBusSignature(''));
  }

  Future<void> removePackages(Iterable<PackageKitPackageId> packageIds,
      {Set<PackageKitTransactionFlag> transactionFlags = const {},
      bool allowDeps = false,
      bool autoremove = false}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'RemovePackages',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusArray.string(packageIds.map((id) => id.toString())),
          DBusBoolean(allowDeps),
          DBusBoolean(autoremove)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> repairSystem(
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName,
        'RepairSystem', [DBusUint64(_encodeTransactionFlags(transactionFlags))],
        replySignature: DBusSignature(''));
  }

  Future<void> repoEnabled(String repoId, bool enabled) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'RepoEnable',
        [DBusString(repoId), DBusBoolean(enabled)],
        replySignature: DBusSignature(''));
  }

  Future<void> repoRemove(String repoId,
      {Set<PackageKitTransactionFlag> transactionFlags = const {},
      bool autoremove = false}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'RepoRemove',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusString(repoId),
          DBusBoolean(autoremove)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> repositorySetData(
      String repoId, String parameter, String value) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'RepoSetData',
        [DBusString(repoId), DBusString(parameter), DBusString(value)],
        replySignature: DBusSignature(''));
  }

  Future<void> requiredBy(Iterable<PackageKitPackageId> packageIds,
      {Set<PackageKitFilter> filter = const {}, bool recursive = false}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'RequiredBy',
        [
          DBusUint64(_encodeFilters(filter)),
          DBusArray.string(packageIds.map((id) => id.toString())),
          DBusBoolean(recursive)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> resolve(Iterable<String> packages,
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'Resolve',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusArray.string(packages)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> searchDetails(Iterable<String> values,
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'SearchDetails',
        [DBusUint64(_encodeFilters(filter)), DBusArray.string(values)],
        replySignature: DBusSignature(''));
  }

  Future<void> searchFiles(Iterable<String> values,
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'SearchFiles',
        [DBusUint64(_encodeFilters(filter)), DBusArray.string(values)],
        replySignature: DBusSignature(''));
  }

  Future<void> searchGroups(Iterable<String> values,
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'SearchGroups',
        [DBusUint64(_encodeFilters(filter)), DBusArray.string(values)],
        replySignature: DBusSignature(''));
  }

  Future<void> searchNames(Iterable<String> values,
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'SearchNames',
        [DBusUint64(_encodeFilters(filter)), DBusArray.string(values)],
        replySignature: DBusSignature(''));
  }

  Future<void> _setHints(Iterable<String> hints) async {
    await _object.callMethod(_packageKitTransactionInterfaceName, 'SetHints',
        [DBusArray.string(hints)],
        replySignature: DBusSignature(''));
  }

  Future<void> updatePackages(Iterable<PackageKitPackageId> packageIds,
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'UpdatePackages',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusArray.string(packageIds.map((id) => id.toString()))
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> upgradeSystem(
      String distroId, PackageKitDistroUpgrade upgradeKind,
      {Set<PackageKitTransactionFlag> transactionFlags = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'UpgradeSystem',
        [
          DBusUint64(_encodeTransactionFlags(transactionFlags)),
          DBusString(distroId),
          DBusUint32(upgradeKind.index)
        ],
        replySignature: DBusSignature(''));
  }

  Future<void> whatProvides(Iterable<String> values,
      {Set<PackageKitFilter> filter = const {}}) async {
    await _object.callMethod(
        _packageKitTransactionInterfaceName,
        'WhatProvides',
        [DBusUint64(_encodeFilters(filter)), DBusArray.string(values)],
        replySignature: DBusSignature(''));
  }
}

/// A client that connects to PackageKit.
class PackageKitClient {
  /// The bus this client is connected to.
  final DBusClient _bus;
  final bool _closeBus;

  /// The root D-Bus PackageKit object.
  late final DBusRemoteObject _root;

  /// Properties on the root object.
  final _properties = <String, DBusValue>{};

  String? locale;
  bool background = false;
  bool interactive = true;
  bool idle = true;
  int cacheAge = 0xffffffff;

  String get backendAuthor =>
      (_properties['BackendAuthor'] as DBusString).value;
  String get backendDescription =>
      (_properties['BackendDescription'] as DBusString).value;
  String get backendName => (_properties['BackendName'] as DBusString).value;
  String get distroId => (_properties['DistroId'] as DBusString).value;
  Set<PackageKitFilter> get filters =>
      _decodeFilters((_properties['Filters'] as DBusUint64).value);
  Set<PackageKitGroup> get groups =>
      _decodeGroups((_properties['Groups'] as DBusUint64).value);
  bool get locked => (_properties['Locked'] as DBusBoolean).value;
  List<String> get mimeTypes => (_properties['MimeTypes'] as DBusArray)
      .children
      .map((value) => (value as DBusString).value)
      .toList();
  Set<PackageKitRole> get roles =>
      _decodeRoles((_properties['Roles'] as DBusUint64).value);
  PackageKitNetworkState get networkState => PackageKitNetworkState
      .values[(_properties['NetworkState'] as DBusUint32).value];
  int get versionMajor => (_properties['VersionMajor'] as DBusUint32).value;
  int get versionMinor => (_properties['VersionMinor'] as DBusUint32).value;
  int get versionMicro => (_properties['VersionMicro'] as DBusUint32).value;

  /// Creates a new PackageKit client connected to the system D-Bus.
  PackageKitClient({DBusClient? bus})
      : _bus = bus ?? DBusClient.system(),
        _closeBus = bus == null {
    _root = DBusRemoteObject(_bus, _packageKitBusName,
        DBusObjectPath('/org/freedesktop/PackageKit'));
  }

  /// Connects to the PackageKit daemon.
  Future<void> connect() async {
    _properties.addAll(await _root.getAllProperties(_packageKitInterfaceName));
  }

  Future<PackageKitTransaction> createTransaction() async {
    var result = await _root.callMethod(
        _packageKitInterfaceName, 'CreateTransaction', [],
        replySignature: DBusSignature('o'));
    var transaction =
        PackageKitTransaction(_bus, result.returnValues[0] as DBusObjectPath);

    var hints = <String>[];
    if (locale != null) {
      hints.add('locale=$locale');
    }
    hints.add('background=${background ? 'true' : 'false'}');
    hints.add('interactive=${interactive ? 'true' : 'false'}');
    hints.add('idle=${idle ? 'true' : 'false'}');
    hints.add('cache-age=$cacheAge');
    await transaction._setHints(hints);

    return transaction;
  }

  /// Terminates the connection to the PackageKit daemon. If a client remains unclosed, the Dart process may not terminate.
  Future<void> close() async {
    if (_closeBus) {
      await _bus.close();
    }
  }
}

bool _listsEqual<T>(List<T> a, List<T> b) {
  if (a.length != b.length) {
    return false;
  }

  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }

  return true;
}
