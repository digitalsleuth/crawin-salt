{% set version = 'v.0.0.66.0' %}
{% set hash = 'BC2CD203EB943AD7ABDDC8158C66D18DA0734FC2F4A32EF0DE65790D94AB278E' %}
{% set confighash = '85110db9b863a6b3688e63c92f104267c323c5fd1bd74a9b16e119f502db5081' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

mftbrowser-download:
  file.managed:
    - name: 'C:\standalone\mftbrowser\MFTBrowser.exe'
    - source: https://github.com/kacos2000/MFT_Browser/releases/download/{{ version }}/MFTBrowser.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

mftbrowser-config-download:
  file.managed:
    - name: 'C:\standalone\mftbrowser\MFTBrowser.exe.config'
    - source: https://github.com/kacos2000/MFT_Browser/releases/download/{{ version }}/MFTBrowser.exe.config
    - source_hash: sha256={{ confighash }}
    - makedirs: True
    - require:
      - file: mftbrowser-download

crawin-standalones-mftbrowser-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\MFTBrowser.lnk'
    - target: 'C:\standalone\mftbrowser\MFTBrowser.exe'
    - force: True
    - working_dir: 'C:\standalone\mftbrowser\'
    - makedirs: True
    - require:
      - file: mftbrowser-download
