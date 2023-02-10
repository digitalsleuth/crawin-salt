# Name: ILEAPP
# Website: https://github.com/abrignoni/ileapp
# Description: iOS Logs Events and Plists Parser
# Category: Mobile Analysis
# Author: Alexis Brignoni
# License: MIT License (https://github.com/abrignoni/iLEAPP/blob/main/LICENSE)
# Version: 1.18.1
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.packages.python3
  - crawin.packages.git

crawin-python3-ileapp-source:
  git.latest:
    - name: https://github.com/abrignoni/ileapp
    - target: '{{ inpath }}\ileapp'
    - rev: main
    - force_clone: True
    - force_reset: True
    - force_fetch: True
    - require:
      - sls: crawin.packages.git

crawin-python3-ileapp-requirements:
  pip.installed:
    - requirements: '{{ inpath }}\ileapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: crawin-python3-ileapp-source
      - sls: crawin.packages.python3

crawin-python3-ileapp-header:
  file.prepend:
    - names:
      - '{{ inpath }}\ileapp\ileapp.py'
      - '{{ inpath }}\ileapp\ileappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: crawin-python3-ileapp-source
      - pip: crawin-python3-ileapp-requirements

crawin-python3-ileapp-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\ileapp\'

crawin-python3-ileapp-icon:
  file.managed:
    - name: '{{ inpath }}\abrignoni-logo.ico'
    - source: salt://crawin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

crawin-python3-ileapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\ILEAPP-GUI.lnk'
    - target: '{{ inpath }}\ileapp\ileappGUI.py'
    - force: True
    - working_dir: '{{ inpath }}\ileapp\'
    - icon_location: '{{ inpath }}\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: crawin-python3-ileapp-source
      - pip: crawin-python3-ileapp-requirements
      - file: crawin-python3-ileapp-header
      - win_path: crawin-python3-ileapp-env-vars
      - file: crawin-python3-ileapp-icon
