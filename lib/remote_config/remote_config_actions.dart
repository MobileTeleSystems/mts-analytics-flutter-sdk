enum RemoteConfigMethod {
  setDefaultsMap('rc.setDefaultsMap'),
  fetchRemoteConfigValues('rc.fetchRemoteConfigValues'),
  activate('rc.activate'),
  fetchRemoteConfigValuesAndActivate('rc.fetchRemoteConfigValuesAndActivate'),
  getConfigValue('rc.getConfigValue'),
  getDefaultConfigValue('rc.getDefaultConfigValue'),
  minFetchInterval('rc.minFetchInterval'),
  activeConfigValues('rc.activeConfigValues');

  const RemoteConfigMethod(this.value);
  final String value;
}
