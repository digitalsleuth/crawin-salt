include:
  - crawin.installers.fec
  - crawin.installers.dcode
  - crawin.installers.vscode
  - crawin.installers.mobaxterm
  - crawin.installers.data-dump
  - crawin.installers.hxd
  - crawin.installers.redline
  - crawin.installers.systools-pst-viewer
  - crawin.installers.irfanview-plugins
  - crawin.installers.magnet-axiom
  - crawin.installers.nuix-evidence-mover
  - crawin.installers.fastcopy
  
crawin-installers:
  test.nop:
    - require:
      - sls: crawin.installers.fec
      - sls: crawin.installers.dcode
      - sls: crawin.installers.vscode
      - sls: crawin.installers.mobaxterm
      - sls: crawin.installers.data-dump
      - sls: crawin.installers.hxd
      - sls: crawin.installers.redline
      - sls: crawin.installers.systools-pst-viewer
      - sls: crawin.installers.irfanview-plugins
      - sls: crawin.installers.magnet-axiom
      - sls: crawin.installers.nuix-evidence-mover
      - sls: crawin.installers.fastcopy
