# Name: 7-Zip
# Website: https://7-zip.org
# Description: Zip Compiler and Extractor
# Category: Requirements
# Author: Igor Pavlov
# License: GNU LGPL (https://www.7-zip.org/faq.html)
# Notes: 
# Version: 21.06

7zip:
  pkg.installed

7zip-env-vars:
  win_path.exists:
    - name: 'C:\Program Files\7-Zip'
