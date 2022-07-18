# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - crawin.packages.python3

usbdeviceforensics:
  pip.installed:
    - name: 'git+https://github.com/digitalsleuth/usbdeviceforensics.git'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: crawin.packages.python3
