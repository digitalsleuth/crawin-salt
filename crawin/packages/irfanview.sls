# Name: IrfanView Plugins
# Website: https://www.irfanview.com
# Description: Photo Editor
# Category: Utilities
# Author: Irfan Skilijan
# License: EULA - https://www.irfanview.com/eula.htm
# Version: 4.59
# Notes:

include:
  - crawin.repos

irfanview:
  pkg.installed:
    - require:
      - sls: crawin.repos
