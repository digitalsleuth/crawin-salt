# Name: Magnet ACQUIRE
# Website: https://www.magnetforensics.com
# Description: Forensic Acquisition Tool
# Category: Acquisition and Analysis
# Author: Jad Saliba - Magnet Forensics
# License: EULA
# Version: 2.53.0.30579
# Notes:

include:
  - crawin.installers.dotnetfx35

magnet-acquire:
  pkg.installed:
    - require:
      - sls: crawin.installers.dotnetfx35
