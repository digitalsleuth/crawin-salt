include:
  - crawin.config
  - crawin.addon
  - crawin.config.layout
  - crawin.theme
 
crawin-dedicated:
  test.nop:
    - require:
      - sls: crawin.config
      - sls: crawin.addon
      - sls: crawin.config.layout
      - sls: crawin.theme
