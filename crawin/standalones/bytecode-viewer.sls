# Name: Bytecode Viewer
# Website: https://github.com/konloch/bytecode-viewer
# Description: Android APK reverse engineering suite
# Category: Mobile Analysis
# Author: Konloch
# License: GNU General Public License v3 (https://github.com/Konloch/bytecode-viewer/blob/master/LICENSE)
# Version: 2.11.2
# Notes: 

{% set version = '2.11.2' %}
{% set hash = '536ad387424106083f76cd0cb7c051a22aff21f08663ba2539c11f1ddef9147f' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - crawin.installers.jre8

bytecode-viewer-download:
  file.managed:
    - name: 'C:\standalone\bytecode-viewer\Bytecode-Viewer-{{ version }}.jar'
    - source: https://github.com/Konloch/bytecode-viewer/releases/download/v{{ version }}/Bytecode-Viewer-{{ version }}.jar
    - source_hash: sha256={{ hash }}
    - makedirs: True

crawin-standalones-bytecode-viewer-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Bytecode Viewer.lnk'
    - target: 'C:\standalone\bytecode-viewer\Bytecode-Viewer-{{ version }}.jar'
    - force: True
    - working_dir: 'C:\standalone\bytecode-viewer\'
    - makedirs: True
    - require:
      - file: bytecode-viewer-download
      - sls: crawin.installers.jre8
