# Name: VLEAPP
# Website: https://github.com/abrignoni/vleapp
# Description: Vehicle Logs Events and Properties Parser
# Category: Mobile Analysis
# Author: Alexis Brignoni
# License: MIT License (https://github.com/abrignoni/VLEAPP/blob/main/LICENSE)
# Version: 1.0.0
# Notes: 

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.packages.python3
  - crawin.packages.git
  - crawin.packages.ms-vcpp-2015-build-tools

crawin-python3-vleapp-source:
  git.latest:
    - name: https://github.com/abrignoni/vleapp
    - target: 'C:\standalone\vleapp'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: crawin.packages.git

crawin-python3-vleapp-requirements:
  pip.installed:
    - requirements: 'C:\standalone\vleapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: crawin-python3-vleapp-source
      - sls: crawin.packages.python3

crawin-python3-vleapp-header:
  file.prepend:
    - names:
      - 'C:\standalone\vleapp\vleapp.py'
      - 'C:\standalone\vleapp\vleappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: crawin-python3-vleapp-source
      - pip: crawin-python3-vleapp-requirements

crawin-python3-vleapp-env-vars:
  win_path.exists:
    - name: 'C:\standalone\vleapp\'

crawin-python3-vleapp-icon:
  file.managed:
    - name: 'C:\standalone\abrignoni-logo.ico'
    - source: salt://crawin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

crawin-python3-vleapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\VLEAPP-GUI.lnk'
    - target: 'C:\standalone\vleapp\vleappGUI.py'
    - force: True
    - working_dir: 'C:\standalone\vleapp\'
    - icon_location: 'C:\standalone\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: crawin-python3-vleapp-source
      - pip: crawin-python3-vleapp-requirements
      - file: crawin-python3-vleapp-header
      - win_path: crawin-python3-vleapp-env-vars
      - file: crawin-python3-vleapp-icon
