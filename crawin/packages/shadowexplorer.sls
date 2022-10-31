include:
  - crawin.installers.dotnetfx35

shadowexplorer:
  pkg.installed:
    - require:
      - sls: crawin.installers.dotnetfx35
