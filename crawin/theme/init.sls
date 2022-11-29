#{% set hash = '22243006EA2EAD213A20A6679A154CCD9A9373BA08F60DEA1512D4AAB9A3638C' %}
{% set colour = 'blue' %}
{% set hash = '8dc64081e005748722849327bd983e459df2ee073f8627a7a0c6b32716973763' %}

crawin-theme-wallpaper-source:
  file.managed:
    - name: 'C:\standalone\crawin-wallpaper-{{ colour }}.png'
    - source: salt://crawin/theme/crawin-wallpaper-{{ colour }}.png
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - win_inheritance: True

crawin-theme-desktop-background-color:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Colors
    - vname: Background
    - vtype: REG_SZ
    - vdata: "0 0 0"

crawin-theme-set-wallpaper:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: WallPaper
    - vtype: REG_SZ
    - vdata: 'C:\standalone\crawin-wallpaper-{{ colour }}.png'

crawin-theme-set-wallpaper-center:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: WallpaperStyle
    - vtype: REG_SZ
    - vdata: 6

crawin-theme-set-wallpaper-no-tile:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: TileWallpaper
    - vtype: REG_SZ
    - vdata: 0

crawin-theme-update-wallpaper:
  cmd.run:
    - name: 'RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True'
    - shell: cmd

nimi-taskkill:
  cmd.run:
    - name: 'taskkill /F /IM "Nimi Places.exe"'
    - bg: True

nimi-setup:
  file.managed:
    - name: 'C:\salt\tempdownload\nimi.zip'
    - source: salt://crawin/files/nimi.zip
    - makedirs: True

nimi-extract:
  archive.extracted:
    - name: 'C:\standalone\nimi\'
    - source: 'C:\salt\tempdownload\nimi.zip'
    - enforce_toplevel: False
    - require:
      - file: nimi-setup

nimi-autostart:
  reg.present:
    - name: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
    - vname: NimiPlaces
    - vtype: REG_SZ
    - vdata: '"C:\standalone\nimi\nimi.cmd"'

cleanup-nimi:
  file.absent:
    - name: 'C:\salt'
    - require:
      - reg: nimi-autostart

nimi-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Nimi Places.lnk'
    - target: 'C:\standalone\nimi\nimi.cmd'
    - force: True
    - working_dir: 'C:\standalone\nimi'
    - icon_location: 'C:\standalone\nimi\Nimi Places.exe'
    - makedirs: True
    - require:
      - archive: nimi-extract
