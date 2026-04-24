# Hướng dẫn

1. Unzip [OpCore-Simplify-main.zip](./Tools/OpCore-Simplify-main.zip) và run file OpCore-Simplify.bat
2. Thực hiện tuần tự các lựa chọn: Scan hardware compatibility -> Choose macOS version -> Build OpenCore EFI
3. Run [USBToolBox.exe](./Tools/USBToolBox.exe) và lần lượt thử hết tất cả các port và protocol của máy để file exe nhận diện đầy đủ, nhấn K để build UTBMap.kext và move nó vào /EFI/OC/Kexts
4. Unzip [USBToolBox-1.2.0-RELEASE.zip](./Tools/USBToolBox-1.2.0-RELEASE.zip) và copy USBToolBox.kext trong đó sang /EFI/OC/Kexts
5. Unzip [OCAT-Win64.zip](./Tools/OCAT-Win64.zip) và run file OCAuxiliaryTools.exe
6. Open /EFI/OC/config.plist with this .exe và add tất cả kext của những bước trước
7. Flash USB bằng [rufus-4.13p.exe](./Tools/rufus-4.13p.exe) với settings
   - Boot selection: Non bootable
   - Partition scheme: GPT
   - File system: FAT32
8. Xóa các file autorun do Rufus khởi tạo và move /EFI/ vào đó
9. Unzip [OpenCore-1.0.7-RELEASE.zip](./Tools/OpenCore-1.0.7-RELEASE.zip), tìm folder "macrecovery" và gõ "cmd" trên thanh directory
10. Tìm phiên bản macOS đồng bộ với các bước trên để chọn lệnh python phù hợp và run nó trong "cmd" bạn vừa mở:
```
python3 ./macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000000000 download
```
11. Move toàn bộ folder mà lệnh trên cho ra (thường có tên "com.apple.recovery.boot") qua USB cùng cấp với folder EFI
12. Tạo phân vùng chứa macOS của bạn (tối thiểu 50GB)
  - File system: exFAT
  - Volume label: macOS
13. Boot bằng USB đó, vào OpenCore và cài macOS
14. Select [OCAT_Mac.dmg](./Tools/OCAT_Mac.dmg) và run OCAuxiliaryTools trong đó
  - Nếu gặp lỗi bảo mật, vào Settings -> Privacy & Security -> dòng nào có nhắc đến OCAuxiliaryTools thì nhấn "Open Anyway" -> Enter PIN
15. Mount ESP partition để phân vùng EFI của ổ cứng xuất hiện trong Finder
16. Copy /EFI/Boot và /EFI/OC folder từ USB qua cùng cấp với folder /EFI/Boot của ESP để merge folder
17. Tùy chỉnh và hoàn thành theo cách của bạn
18. Lần đầu tiên reboot sẽ không vào thẳng OpenCore thì hãy chạy cmd quyền Admin:
```
bcdedit /set {bootmgr} path \efi\boot\bootx64.efi
```
