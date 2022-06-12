@echo off
setlocal EnableDelayedExpansion
title CRA-WIN WSL Config
%1 %2 mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof
:runas
echo $saltArgs = "-l debug --local --retcode-passthrough --log-file=`"C:\crawin-wsl.log`" --log-file-level=debug --out-file=`"C:\crawin-wsl.log`" --out-file-append --state-output=mixed state.sls crawin.wsl.wsl-config pillar=`"{'crawin_user': '_this_user_'}`""> C:\salt\tempdownload\wsl-after-reboot.ps1
type "C:\ProgramData\Salt Project\Salt\srv\salt\crawin\wsl\wsl.ps1" >> C:\salt\tempdownload\wsl-after-reboot.ps1
powershell -f C:\salt\tempdownload\wsl-after-reboot.ps1
