include:
  - crawin.python3-tools.volatility3
  - crawin.python3-tools.autotimeliner
  - crawin.python3-tools.bitsparser
  - crawin.python3-tools.usbdeviceforensics
  - crawin.python3-tools.iptools
  - crawin.python3-tools.oledump
  - crawin.python3-tools.rtfdump
  - crawin.python3-tools.msoffcrypto-crack
  - crawin.python3-tools.xlmmacrodeobfuscator
  - crawin.python3-tools.oletools
  - crawin.python3-tools.pdfid
  - crawin.python3-tools.wleapp
  - crawin.python3-tools.aleapp
  - crawin.python3-tools.ileapp
  - crawin.python3-tools.vleapp
  - crawin.python3-tools.time-decode

crawin-python3-tools:
  test.nop:
    - require:
      - sls: crawin.python3-tools.volatility3
      - sls: crawin.python3-tools.autotimeliner
      - sls: crawin.python3-tools.bitsparser
      - sls: crawin.python3-tools.usbdeviceforensics
      - sls: crawin.python3-tools.iptools
      - sls: crawin.python3-tools.oledump
      - sls: crawin.python3-tools.rtfdump
      - sls: crawin.python3-tools.msoffcrypto-crack
      - sls: crawin.python3-tools.xlmmacrodeobfuscator
      - sls: crawin.python3-tools.oletools
      - sls: crawin.python3-tools.pdfid
      - sls: crawin.python3-tools.wleapp
      - sls: crawin.python3-tools.aleapp
      - sls: crawin.python3-tools.ileapp
      - sls: crawin.python3-tools.vleapp
      - sls: crawin.python3-tools.time-decode

python3-filetype-association:
  cmd.run:
    - name: 'ftype Python.File="C:\Windows\py.exe" %L %*'
    - shell: cmd

python3-pathext:
  cmd.run:
    - names:
      - setx /M PATHEXT "%PATHEXT:;.PY;.PYW=%"
      - setx /M PATHEXT "%PATHEXT%;.PY;.PYW"
    - shell: cmd
