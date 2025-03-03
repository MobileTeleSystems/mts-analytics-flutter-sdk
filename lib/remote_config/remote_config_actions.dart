enum RemoteConfigMethod {
  setDefaultsMap('rc.setDefaultsMap'),
  fetchRemoteConfigValues('rc.fetchRemoteConfigValues'),
  activate('rc.activate'),
  fetchRemoteConfigValuesAndActivate('rc.fetchRemoteConfigValuesAndActivate'),
  getConfigValue('rc.getConfigValue'),
  getDefaultConfigValue('rc.getDefaultConfigValue'),
  minFetchInterval('rc.minFetchInterval');

  const RemoteConfigMethod(this.value);
  final String value;
}
