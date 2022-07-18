#{% set wallpaper = [('red', '22243006EA2EAD213A20A6679A154CCD9A9373BA08F60DEA1512D4AAB9A3638C')] %}
{% set colour = 'red' %}
#{% set hash = '423EE00AFDB44EC7FA480DB803E6C0C55DD9EED7ECF88DEB2453D47972749C9C' %}
{% set hash = '22243006EA2EAD213A20A6679A154CCD9A9373BA08F60DEA1512D4AAB9A3638C' %}

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
    - vdata: 0

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


