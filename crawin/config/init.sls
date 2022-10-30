include:
  - crawin.config.user
  - crawin.config.debloat-windows
  - crawin.config.computer-name
  - crawin.config.pdfs
  - crawin.config.del-edge-shortcut
  - crawin.config.admin-cmd-prompt
  - crawin.config.admin-posh-prompt

crawin-config:
  test.nop:
    - require:
      - sls: crawin.config.user
      - sls: crawin.config.debloat-windows
      - sls: crawin.config.computer-name
      - sls: crawin.config.pdfs
      - sls: crawin.config.del-edge-shortcut
      - sls: crawin.config.admin-cmd-prompt
      - sls: crawin.config.admin-posh-prompt
