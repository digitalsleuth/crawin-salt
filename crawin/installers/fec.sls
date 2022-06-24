{% set version = '3.75.1.10' %}
{% set hash = 'EA818D135D6530732A39913B10457AF942263AC18345E4D79357DFE15E6DB5D7' %}
{% set folder_hash = '7af53cc2b748' %}

fec-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe'
    - source: https://storage.googleapis.com/fec-downloads/FEC/{{ version }}_{{ folder_hash }}/FECSetup_v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

fec-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe /qn /norestart'
    - shell: cmd
