@echo off
setlocal
set "EfiDrive=Z:"

:: --- ĐOẠN MÃ TỰ ĐỘNG YÊU CẦU QUYỀN ADMIN ---
:checkPrivileges
net file 1>nul 2>nul
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (shift & goto gotPrivileges)  
echo Dang yeu cau quyen Admin...
setlocal DisableDelayedExpansion
set "batchPath=%~f0"
setlocal EnableDelayedExpansion
echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPriv.vbs"
echo UAC.ShellExecute "cmd.exe", "/c ""!batchPath!"" ELEV", "", "runas", 1 >> "%temp%\OEgetPriv.vbs"
"%temp%\OEgetPriv.vbs"
exit /B

:gotPrivileges
:: --- BẮT ĐẦU THỰC THI LỆNH SAU KHI CÓ QUYỀN ---
echo [OK] Da co quyen Admin.

:: 1. Tu dong tim va gan ky tu cho phan vung EFI
echo Yeu cau gan phan vung EFI.
powershell -Command "$efi = Get-Partition | Where-Object { $_.GptType -eq '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' } | Select-Object -First 1; if ($efi) { Add-PartitionAccessPath -DiskNumber $efi.DiskNumber -PartitionNumber $efi.PartitionNumber -AccessPath '%EfiDrive%' -ErrorAction SilentlyContinue } else { Write-Host 'Khong tim thay phan vung EFI!' -ForegroundColor Red }"

:: 2. Mo Notepad voi file cau hinh
if exist %EfiDrive%\EFI\refind\refind.conf (
    echo Dang mo refind.conf...
    start notepad.exe "%EfiDrive%\EFI\refind\refind.conf"
) else (
    echo [!] Khong tim thay file refind.conf tai %EfiDrive%\EFI\refind\
    echo Dang mo thu muc EFI de ban tu kiem tra...
    start explorer.exe "%EfiDrive%\"
)

exit