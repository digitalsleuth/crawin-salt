include:
  - crawin.packages.7zip
  - crawin.packages.git
  - crawin.packages.ms-vcpp-2015-build-tools
  - crawin.packages.autopsy
  - crawin.packages.firefox
  - crawin.packages.chrome
  - crawin.packages.registry-viewer
  - crawin.packages.ftk-imager
  - crawin.packages.httplogbrowser
  - crawin.packages.db-browser-sqlite
  - crawin.packages.bulk-extractor
  - crawin.packages.vs-community-2022
  - crawin.packages.vcxsrv
  - crawin.packages.libreoffice
  - crawin.packages.npp
  - crawin.packages.adobereader
  - crawin.packages.python3
  - crawin.packages.python2
  - crawin.packages.sublime-text
  - crawin.packages.passware-encryption-analyzer
  - crawin.packages.logparser
  - crawin.packages.active-disk-editor
  - crawin.packages.kernel-pst-viewer  
  - crawin.packages.kernel-ost-viewer
  - crawin.packages.kernel-edb-viewer
  - crawin.packages.putty
  - crawin.packages.wireshark
  - crawin.packages.strawberryperl
  - crawin.packages.cerbero-suite
  - crawin.packages.fiddler
  - crawin.packages.mdf-viewer
  - crawin.packages.free-hex-editor-neo
  - crawin.packages.pdfstreamdumper
  - crawin.packages.magnet-chromebook-acquisition
  - crawin.packages.magnet-acquire
  - crawin.packages.openhashtab
  - crawin.packages.irfanview
  - crawin.packages.dbeaver

crawin-packages:
  test.nop:
    - require:
      - sls: crawin.packages.7zip
      - sls: crawin.packages.git
      - sls: crawin.packages.ms-vcpp-2015-build-tools
      - sls: crawin.packages.autopsy
      - sls: crawin.packages.firefox
      - sls: crawin.packages.chrome
      - sls: crawin.packages.registry-viewer
      - sls: crawin.packages.ftk-imager
      - sls: crawin.packages.httplogbrowser
      - sls: crawin.packages.db-browser-sqlite
      - sls: crawin.packages.bulk-extractor
      - sls: crawin.packages.vs-community-2022
      - sls: crawin.packages.vcxsrv
      - sls: crawin.packages.libreoffice
      - sls: crawin.packages.npp
      - sls: crawin.packages.adobereader
      - sls: crawin.packages.python3
      - sls: crawin.packages.python2
      - sls: crawin.packages.sublime-text
      - sls: crawin.packages.passware-encryption-analyzer
      - sls: crawin.packages.logparser
      - sls: crawin.packages.active-disk-editor
      - sls: crawin.packages.kernel-pst-viewer
      - sls: crawin.packages.kernel-ost-viewer
      - sls: crawin.packages.kernel-edb-viewer
      - sls: crawin.packages.putty
      - sls: crawin.packages.wireshark
      - sls: crawin.packages.strawberryperl
      - sls: crawin.packages.cerbero-suite
      - sls: crawin.packages.fiddler
      - sls: crawin.packages.mdf-viewer
      - sls: crawin.packages.free-hex-editor-neo
      - sls: crawin.packages.pdfstreamdumper
      - sls: crawin.packages.magnet-chromebook-acquisition
      - sls: crawin.packages.magnet-acquire
      - sls: crawin.packages.openhashtab
      - sls: crawin.packages.irfanview
      - sls: crawin.packages.dbeaver
