# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.packages.python3
  - crawin.packages.git
  - crawin.packages.ms-vcpp-2015-build-tools

crawin-python3-ileapp-source:
  git.latest:
    - name: https://github.com/abrignoni/ileapp
    - target: 'C:\standalone\ileapp'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: crawin.packages.git

crawin-python3-ileapp-requirements:
  pip.installed:
    - requirements: 'C:\standalone\ileapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: crawin-python3-ileapp-source
      - sls: crawin.packages.python3
      - sls: crawin.packages.ms-vcpp-2015-build-tools

crawin-python3-ileapp-header:
  file.prepend:
    - names:
      - 'C:\standalone\ileapp\ileapp.py'
      - 'C:\standalone\ileapp\ileappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: crawin-python3-ileapp-source
      - pip: crawin-python3-ileapp-requirements

crawin-python3-ileapp-env-vars:
  win_path.exists:
    - name: 'C:\standalone\ileapp\'

crawin-python3-ileapp-icon:
  file.managed:
    - name: 'C:\standalone\abrignoni-logo.ico'
    - source: salt://crawin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

crawin-python3-ileapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\ILEAPP-GUI.lnk'
    - target: 'C:\standalone\ileapp\ileappGUI.py'
    - force: True
    - working_dir: 'C:\standalone\ileapp\'
    - icon_location: 'C:\standalone\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: crawin-python3-ileapp-source
      - pip: crawin-python3-ileapp-requirements
      - file: crawin-python3-ileapp-header
      - win_path: crawin-python3-ileapp-env-vars
      - file: crawin-python3-ileapp-icon
