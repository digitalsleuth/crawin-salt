include:
  - crawin.repos

wsl2-update:
  pkg.installed:
    - require:
      - sls: crawin.repos
