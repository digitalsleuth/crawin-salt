# Name: USB Registry Write Blocker
# Website: https://github.com/digitalsleuth/registry-write-block
# Description: USB Write Blocker for standard USB / UASP devices using Registry Modifications
# Category: Utilities
# Author: Corey Forman
# License: MIT License (https://github.com/digitalsleuth/Registry-Write-Block/blob/master/LICENSE)
# Version: 1.2
# Notes: 

{% set version = '1.2' %}
{% set hash = '7b52d5b84310bfaec1f9cfb739e7b1c8731af1eb73d9ed4cfeb31bb7118ad2b0' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

crawin-standalones-usb-write-blocker:
  file.managed:
    - name: 'C:\standalone\USB-Write-Blocker_v{{ version }}.exe'
    - source: https://github.com/digitalsleuth/Registry-Write-Block/releases/download/{{ version }}/USB-Registry-Write-Block-PS3x64-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

crawin-standalones-usb-write-blocker-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\USB Write Blocker.lnk'
    - target: 'C:\standalone\USB-Write-Blocker_v{{ version }}.exe'
    - force: True
    - working_dir: 'C:\standalone\'
    - makedirs: True
    - require:
      - file: crawin-standalones-usb-write-blocker

crawin-standalones-usb-write-blocker-env-vars:
  win_path.exists:
    - name: 'C:\standalone\'
