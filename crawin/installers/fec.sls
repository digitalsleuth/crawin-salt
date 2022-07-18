# Name: Forensic Email Collector
# Website: https://metaspike.com
# Description: Local and Remote email acquisition tool
# Category: Email
# Author: Arman Gungor - Metaspike
# License: 
# Version: 3.75.1.13
# Notes:

{% set version = '3.75.1.13' %}
{% set hash = '6d24d8facc6c316d7930da1b40d06845941414fa884900a6d23113d399150ff4' %}
{% set folder_hash = '8e3de57bba47' %}

fec-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe'
    - source: https://storage.googleapis.com/fec-downloads/FEC/{{ version }}_{{ folder_hash }}/FECSetup_v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

fec-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe /q /norestart'
    - shell: cmd
