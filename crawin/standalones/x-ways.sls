{% set version = "205" %}
{% set auth_token = "TOKENPLACEHOLDER" %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

{% if auth_token == "TOKENPLACEHOLDER" %}

xways-credentials-not-provided:
  test.nop

{% else %}
xways-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/xwf/xw_forensics{{ version }}.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\xw_forensics{{ version }}.zip'
    - shell: powershell

xways-viewer-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/viewer/xw_viewer.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\xw_viewer.zip'
    - shell: powershell

xways-tesseract-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/Tesseract.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\Tesseract.zip'
    - shell: powershell

xways-mplayer-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/mplayer/MPlayer 2018 x64.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\MPlayer_2018_x64.zip'
    - shell: powershell

xways-manual-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/winhex/manual.pdf" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\manual.pdf'
    - shell: powershell

xways-extract:
  archive.extracted:
    - name: 'C:\xwf\'
    - source: 'C:\salt\tempdownload\xw_forensics{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - cmd: xways-download

xways-viewer-extract:
  archive.extracted:
    - name: 'C:\xwf\'
    - source: 'C:\salt\tempdownload\xw_viewer.zip'
    - enforce_toplevel: False
    - require:
      - cmd: xways-viewer-download
      - archive: xways-extract

xways-tesseract-extract:
  archive.extracted:
    - name: 'C:\xwf\'
    - source: 'C:\salt\tempdownload\xw_forensics{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - cmd: xways-tesseract-download
      - archive: xways-extract

xways-mplayer-extract:
  archive.extracted:
    - name: 'C:\xwf\'
    - source: 'C:\salt\tempdownload\MPlayer_2018_x64.zip'
    - enforce_toplevel: False
    - require:
      - cmd: xways-mplayer-download
      - archive: xways-extract

xways-manual-download:
  file.managed:
    - name: 'C:\xwf\manual.pdf'
    - source: 'C:\salt\tempdownload\manual.pdf'
    - require:
      - cmd: xways-manual-download
      - archive: xways-extract

xways-winhex-binary:
  file.copy:
    - name: 'C:\xwf\winhex.exe'
    - source: 'C:\xwf\xwforensics.exe'
    - require:
      - archive: xways-extract

xways-winhex64-binary:
  file.copy:
    - name: 'C:\xwf\winhex64.exe'
    - source: 'C:\xwf\xwforensics64.exe'
    - require:
      - archive: xways-extract

crawin-standalones-xways-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\X-Ways.lnk'
    - target: 'C:\xwf\xwforensics64.exe'
    - force: True
    - working_dir: 'C:\xwf\'
    - makedirs: True
    - require:
      - archive: xways-extract

crawin-standalones-winhex-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\WinHex.lnk'
    - target: 'C:\xwf\winhex64.exe'
    - force: True
    - working_dir: 'C:\xwf\'
    - makedirs: True
    - require:
      - archive: xways-extract

{% endif %}
