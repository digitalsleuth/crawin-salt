include:
  - crawin.config.user
  - crawin.repos
  - crawin.installers
  - crawin.packages
  - crawin.standalones
  - crawin.python2-tools
  - crawin.python3-tools
  - crawin.cleanup

crawin-addon-version-file:
  file.managed:
    - name: 'C:\crawin-version'
    - source: salt://crawin/VERSION
    - replace: True
    - require:
      - sls: crawin.config.user
      - sls: crawin.repos
      - sls: crawin.installers
      - sls: crawin.packages
      - sls: crawin.standalones
      - sls: crawin.python2-tools
      - sls: crawin.python3-tools
      - sls: crawin.cleanup
