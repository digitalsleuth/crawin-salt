{% set dot_version = '6.2.0.31740' %}
{% set file_version = '620.31740' %}
{% set hash = '9b25491b2f71a507b145c108805cee83d01a41c044ed33d2870a14f46ec58cf1' %}

magnet-axiom-download:
  file.managed:
    - name: 'C:\salt\tempdownload\AXIOMv{{ file_version }}setup.zip'
    - source: https://prod-releases.magnetforensics.com/axiom/{{ dot_version }}/installer/AXIOMv{{ file_version }}setup.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

magnet-axiom-extract:
  archive.extracted:
    - name: 'C:\salt\tempdownload\AXIOM\'
    - source: 'C:\salt\tempdownload\AXIOMv{{ file_version }}setup.zip'
    - enforce_toplevel: false
    - watch:
      - file: magnet-axiom-download

magnet-axiom-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\AXIOM\AXIOMv{{ file_version }}setup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /MERGETASKS=!DESKTOPICON,!RUNCODE'
    - shell: cmd
