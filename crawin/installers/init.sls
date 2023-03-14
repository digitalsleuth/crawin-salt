include:
  - crawin.installers.fec
  - crawin.installers.dcode
  - crawin.installers.mobaxterm
  - crawin.installers.data-dump
  - crawin.installers.hxd
  - crawin.installers.systools-pst-viewer
  - crawin.installers.irfanview-plugins
  - crawin.installers.magnet-axiom
  - crawin.installers.fastcopy
  - crawin.installers.jre8
  
crawin-installers:
  test.nop:
    - require:
      - sls: crawin.installers.fec
      - sls: crawin.installers.dcode
      - sls: crawin.installers.mobaxterm
      - sls: crawin.installers.data-dump
      - sls: crawin.installers.hxd
      - sls: crawin.installers.systools-pst-viewer
      - sls: crawin.installers.irfanview-plugins
      - sls: crawin.installers.magnet-axiom
      - sls: crawin.installers.fastcopy
      - sls: crawin.installers.jre8
