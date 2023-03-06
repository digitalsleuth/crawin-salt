{% set user = salt['pillar.get']('crawin_user', 'forensics') %}
{% set release = grains['osrelease'] %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
  {% set home = "C:\\Users\\" + user %}
{% endif %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set START_MENU = PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs' %}
{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set portals_configs = ['portals.ptl','globalsettings.ptl'] %}
{% set shortcuts = [('Acquisition and Analysis', ['FTK Imager','Active@ Disk Editor\Active@ Disk Editor','Arsenal Image Mounter','Autopsy\Autopsy 4.20.0','Magnet AXIOM\AXIOM Examine','Magnet AXIOM\AXIOM Process','Cerbero Suite\Cerbero Suite','gkape','Magnet ACQUIRE\Magnet ACQUIRE','Magnet Chromebook Acquisition Assistant v1\Magnet Chromebook Acquisition Assistant v1','Tableau\Tableau Imager\Tableau Imager','X-Ways']),
                    ('Browsers', ['Firefox','Google Chrome','Microsoft Edge']),
                    ('Databases', ['ADOQuery','DataEdit','DB Browser (SQLCipher)','DB Browser (SQLite)','DBeaver Community\DBeaver','SDBExplorer','SQLiteQuery','SQLiteStudio\SQLiteStudio','SysTools SQL MDF Viewer\SysTools SQL MDF Viewer']),
                    ('Document Analysis', ['OffVis','PDFStreamDumper\PdfStreamDumper.exe','SSView']),
                    ('Document Viewers', ['Acrobat Reader','EZViewer','LibreOffice 7.4\LibreOffice Calc','LibreOffice 7.4\LibreOffice Impress','LibreOffice 7.4\LibreOffice Writer','LibreOffice 7.4\LibreOffice','Notepad++','Sublime Text','Visual Studio Code\Visual Studio Code']),
                    ('Email', ['EHB','Metaspike, Inc\Forensic Email Collector\Forensic Email Collector','Kernel Exchange EDB Viewer\Kernel Exchange EDB Viewer','Kernel OST Viewer\Kernel OST Viewer','Kernel Outlook PST Viewer\Kernel Outlook PST Viewer','MailView','SysTools Outlook PST Viewer\SysTools Outlook PST Viewer']),
                    ('Logs', ['EventFinder','EZViewer','HttpLogBrowser\HttpLogBrowser','Log Parser 2.2\Log Parser 2.2','LogParser-Studio','LogViewer2']),
                    ('Mobile Analysis', ['ALEAPP-GUI','ILEAPP-GUI','iPhoneAnalyzer','VLEAPP-GUI']),
                    ('Network', ['Fiddler Classic','IHB','Magnet Web Page Saver Portable V3','NetScanner','PuTTY (64-bit)\PSFTP','PuTTY (64-bit)\PuTTY','Wireshark']),
                    ('Programming', ['Python 3.10\IDLE (Python 3.10 64-bit)','Visual Studio Code\Visual Studio Code','Windows PowerShell\Windows PowerShell ISE']),
                    ('Raw Parsers and Decoders', ['Bulk Extractor 1.5.5\BEViewer with Bulk Extractor 1.5.5 (64-bit)','CyberChef','Digital Detective\DataDump v2\DataDump v2.0','Digital Detective\DCode v5\DCode v5.5','HHD Hex Editor Neo\Hex Editor Neo','HEXEdit','HxD Hex Editor\HxD','JSONView','Passware\Encryption Analyzer 2023 v1\Passware Encryption Analyzer 2023 v1 (64-bit)','XMLView','WinHex']),
                    ('Terminals', ['MobaXterm\MobaXterm','WSL']),
                    ('Utilities', ['Digital Detective\DCode v5\DCode v5.5','EZViewer','FastCopy','Hasher','IrfanView\IrfanView 64 4.60','Monolith Notes',"Nuix\\Nuix Evidence Mover\\Nuix Evidence Mover",'Rufus','Sysinternals','Tableau\Tableau Firmware Update\Tableau Firmware Update','USB Write Blocker','WindowGrid','VcXsrv\XLaunch']),
                    ('Windows Analysis', ['AutoRunner','EXE','JumpListExplorer','LogFileParser64','MFTBrowser','MFTExplorer','NirLauncher','NTFS Log Tracker','Redline\Redline','RegistryExplorer','RegRipper','SE','ShadowExplorer','ShellBagsExplorer'])
                   ] %}

include:
  - crawin.packages.portals
  - crawin.config.user

crawin-theme-wallpaper-source:
  file.managed:
    - name: '{{ inpath }}\crawin-wallpaper.png'
    - source: salt://crawin/theme/crawin-wallpaper.png
    - skip_verify: True
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
    - vdata: '{{ inpath }}\crawin-wallpaper.png'

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

{% for folder in shortcuts %}
shortcut-{{ folder[0] }}:
  file.directory:
    - name: '{{ inpath }}\Portals\{{ folder[0] }}'
    - makedirs: True
    - replace: True
    - win_inheritance: True
{% for shortcut in folder[1] %}
{% set shortcut = shortcut + ".lnk" %}
shortcut-{{ folder[0] }}-{{ shortcut }}:
  file.copy:
    - name: '{{ inpath }}\Portals\{{ folder[0] }}\'
    - source: '{{ START_MENU }}\{{ shortcut }}'
    - preserve: True
    - subdir: True
    - onlyif:
      - fun: file.file_exists
        path: '{{ START_MENU }}\{{ shortcut }}'

{% endfor %}
{% endfor %}

portals-end-process:
  cmd.run:
    - name: 'taskkill /F /IM "Portals.exe"'
    - bg: True
    - require:
      - sls: crawin.packages.portals

{% for config in portals_configs %}
portals-{{ config }}-copy:
  file.managed:
    - name: '{{ home }}\AppData\Local\Portals\{{ config }}'
    - source: salt://crawin/files/{{ config }}
    - makedirs: True
    - replace: True
    - require:
      - user: crawin-user-{{ user }}
      - sls: crawin.packages.portals

portals-{{ config }}-placeholder-replace:
  file.replace:
    - name: '{{ home }}\AppData\Local\Portals\{{ config }}'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: portals-{{ config }}-copy
{% endfor %}

portals-auto-run:
  reg.present:
    - name: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
    - vname: Portals
    - vtype: REG_SZ
    - vdata: 'C:\Program Files\Portals\Portals.exe'

{% if release == '11' %}
move-start-menu-left:
  reg.present:
    - name: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    - vname: TaskbarAl
    - vtype: REG_DWORD
    - vdata: 0
{% endif %}
