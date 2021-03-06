# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - crawin.packages.git

bitsparser-clone:
  git.latest:
    - name: https://github.com/fireeye/bitsparser
    - target: 'C:\standalone\bitsparser'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: crawin.packages.git

bitsparser-requirements:
  pip.installed:
    - requirements: 'C:\standalone\bitsparser\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: bitsparser-clone

bitsparser-header:
  file.prepend:
    - name: 'C:\standalone\bitsparser\BitsParser.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: bitsparser-clone

bitsparser-setup:
  win_path.exists:
    - name: 'C:\standalone\bitsparser\'
