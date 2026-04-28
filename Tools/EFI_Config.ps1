# --- 1. TU DONG YEU CAU QUYEN ADMIN ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Dang yeu cau quyen Admin..." -ForegroundColor Cyan
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- 2. THIET LAP BIEN ---
$EfiDrive = "Z:"
$RefindPath = "$EfiDrive\EFI\refind\refind.conf"

Write-Host "[OK] Da co quyen Admin." -ForegroundColor Green

# --- 3. TIM VA GAN KY TU CHO PHAN VUNG EFI ---
Write-Host "Dang tim phan vung EFI..."
try {
    # Tim phan vung EFI (GptType chuan)
    $efi = Get-Partition | Where-Object { $_.GptType -eq '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}' } | Select-Object -First 1
    
    if ($efi) {
        # Kiem tra xem o Z: da bi chiem chua, neu chua thi gan
        if (!(Test-Path "$EfiDrive")) {
            Add-PartitionAccessPath -DiskNumber $efi.DiskNumber -PartitionNumber $efi.PartitionNumber -AccessPath $EfiDrive
            Write-Host "[OK] Da gan phan vung EFI vao o dia $EfiDrive" -ForegroundColor Green
        } else {
            Write-Host "[!] O dia $EfiDrive da ton tai hoặc đã được gắn." -ForegroundColor Yellow
        }
    } else {
        Write-Error "Khong tim thay phan vung EFI tren he thong!"
        pause
        exit
    }
} catch {
    Write-Error "Loi khi gan o dia: $($_.Exception.Message)"
}

# --- 4. MO FILE CAU HINH HOAC THU MUC ---
if (Test-Path $RefindPath) {
    Write-Host "Dang mo refind.conf bang Notepad..." -ForegroundColor Cyan
    Start-Process notepad.exe $RefindPath
} else {
    Write-Host "[!] Khong tim thay file refind.conf tai $RefindPath" -ForegroundColor Red
    Write-Host "Dang mo thu muc EFI de ban tu kiem tra..."
    Start-Process explorer.exe $EfiDrive
}

# Ket thuc
Write-Host "Script hoan tat." -ForegroundColor Gray