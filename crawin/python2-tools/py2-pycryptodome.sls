# Name: Pycryptodome
# Website: https://github.com/legrandin/pycryptodome
# Description: Python package of low-level cryptographic primitives
# Category: Requirements
# Author: Helder Eijs (Legrandin)
# License: Public Domain / BSD (https://github.com/Legrandin/pycryptodome/blob/master/LICENSE.rst)
# Version: 3.16.0
# Notes: 

include:
  - crawin.packages.vcforpython27
  - crawin.packages.python2

py2-pycryptodome:
  pip.installed:
    - name: 'pycryptodome'
    - bin_env: 'C:\Python27\python.exe'
    - require:
      - sls: crawin.packages.vcforpython27
      - sls: crawin.packages.python2
