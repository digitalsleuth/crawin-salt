# Name: Nirsoft
# Website: https://nirsoft.net
# Description: Suite of various Windows Analysis Tools
# Category: Windows Analysis
# Author: Nir Sofer
# License: 
# Version: 1.23.70
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '1.23.70' %}
{% set hash = '7120472b45946148fc7fbfa1cb3aabb77e86c85b0b0235814093d314857a79ef' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set nlps = ['eztools.nlp', 'mitec.nlp', 'sysinternals6.nlp'] %}

include:
  - crawin.packages.7zip
  - crawin.standalones.sysinternals
  - crawin.standalones.mitec

nirsoft-defender-exclusion:
  cmd.run:
    - name: 'Add-MpPreference -ExclusionPath "{{ inpath }}\"'
    - shell: powershell

nirsoft-download:
  cmd.run:
    - name: 'wget -O C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -Headers @{"Referer"="https://launcher.nirsoft.net/downloads/index.html"} https://download.nirsoft.net/nirsoft_package_enc_{{ version }}.zip'
    - shell: powershell
    - require:
      - cmd: nirsoft-defender-exclusion

nirsoft-extract:
  cmd.run:
    - name: '"C:\Program Files\7-Zip\7z.exe" x C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -o"{{ inpath }}\nirsoft\" -pnirsoft9876$ -y'
    - shell: cmd
    - require:
      - cmd: nirsoft-defender-exclusion
      - cmd: nirsoft-download
    - watch:
      - cmd: nirsoft-defender-exclusion

nirsoft-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\nirsoft\'

nirsoft-nirlauncher-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\NirLauncher.lnk'
    - target: '{{ inpath }}\nirsoft\NirLauncher.exe'
    - force: True
    - working_dir: '{{ inpath }}\nirsoft\'
    - makedirs: True
    - require:
      - cmd: nirsoft-extract

crawin-standalones-nirsoft-cfg-replace:
  file.managed:
    - name: '{{ inpath }}\nirsoft\NirLauncher.cfg'
    - source: salt://crawin/files/NirLauncher.cfg
    - replace: True
    - require:
      - sls: crawin.standalones.sysinternals
      - sls: crawin.standalones.mitec

{% for nlp in nlps %}

crawin-standalones-nirsoft-{{ nlp }}:
  file.managed:
    - name: '{{ inpath }}\nirsoft\{{ nlp }}'
    - source: salt://crawin/files/{{ nlp }}
    - makedirs: True

crawin-standalones-nirsoft-{{ nlp }}-replace-placeholder:
  file.replace:
    - name: '{{ inpath }}\nirsoft\{{ nlp }}'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: crawin-standalones-nirsoft-{{ nlp }}

{% endfor %}
