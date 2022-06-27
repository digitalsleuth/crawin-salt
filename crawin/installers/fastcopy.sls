fastcopy-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FastCopy4.1.7_installer.exe'
    - source: https://github.com/FastCopyLab/FastCopyDist/raw/main/FastCopy4.1.7_installer.exe
    - source_hash: sha256=683E1EB788EF37AF31E521F432B457DF737EDD09D507298C581F24DD6D9ED34D
    - makedirs: True

fastcopy-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\FastCopy4.1.7_installer.exe /SILENT /DIR=C:\standalone\fastcopy /NODESK'
    - shell: cmd
    - require:
      - file: fastcopy-download

