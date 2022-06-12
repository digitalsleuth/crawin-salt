# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.packages.git

crawin-standalones-logfileparser:
  git.latest:
    - name: https://github.com/jschicht/LogFileParser.git
    - target: 'C:\standalone\logfileparser'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: crawin.packages.git

logfileparser-env-vars:
  win_path.exists:
    - name: 'C:\standalone\logfileparser\'

crawin-standalones-logfileparser-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\LogFileParser64.lnk'
    - target: 'C:\standalone\logfileparser\LogFileParser64.exe'
    - force: True
    - working_dir: 'C:\standalone\logfileparser'
    - makedirs: True
    - require:
      - git: crawin-standalones-logfileparser
