# Name: regripper
# Website: https://github.com/keydet89/RegRipper3.0
# Description: Registry parsing toolsuite
# Category: Windows Analysis
# Author: Harlan Carvey
# License: MIT License (https://github.com/keydet89/RegRipper3.0/blob/master/license.md)
# Version: 3.0
# Notes: rr.exe

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.packages.git

crawin-standalones-regripper:
  git.latest:
    - name: https://github.com/keydet89/RegRipper3.0.git
    - target: '{{ inpath }}\regripper'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: crawin.packages.git

regripper-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\regripper\'

crawin-standalones-regripper-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\RegRipper.lnk'
    - target: '{{ inpath }}\regripper\rr.exe'
    - force: True
    - working_dir: '{{ inpath }}\regripper\'
    - makedirs: True
    - require:
      - git: crawin-standalones-regripper
