include:
  - crawin.wsl.wsl
  - crawin.wsl.wsl2-update
  - crawin.wsl.wsl-config
 
crawin-wsl:
  test.nop:
    - require:
      - sls: crawin.wsl.wsl
      - sls: crawin.wsl.wsl2-update
      - sls: crawin.wsl.wsl-config
