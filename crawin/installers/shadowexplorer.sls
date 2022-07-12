include:
  - crawin.installers.dotnetfx35

shadowexplorer-download:
  file.managed:
    - name: 'C:\salt\tempdownload\ShadowExplorer-0.9-setup.exe'
    - source: https://www.shadowexplorer.com/uploads/ShadowExplorer-0.9-setup.exe
    - source_hash: sha256=f81ae34252f9dac08bfee6c4bce5fca99daf0e5fd17a0bc76637d6cbd1c2e875
    - makedirs: True

shadowexplorer-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\ShadowExplorer-0.9-setup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
    - require:
      - sls: crawin.installers.dotnetfx35
