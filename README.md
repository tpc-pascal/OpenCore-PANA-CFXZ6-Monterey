# OpenCore-PANA-CFXZ6-Monterey

OpenCore EFI folder for Panasonic Let's Note / Toughbook CF-XZ6.

<p align="center">
  <img src="macOS_CFXZ6.png" width="400" alt="macOS Monterey on CF-XZ6">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/OpenCore-1.0.x-blue?style=flat-square" alt="OpenCore Version">
  <img src="https://img.shields.io/badge/macOS-Monterey-success?style=flat-square&logo=apple" alt="macOS Version">
  <img src="https://img.shields.io/badge/Status-Incomplete-orange?style=flat-square" alt="Status">
</p>

---

## 💻 Cấu hình phần cứng (System Specs)
Danh sách phần cứng đã được kiểm chứng trên thiết bị thực tế:

| Thành phần | Chi tiết | Ghi chú |
| :--- | :--- | :--- |
| **Model** | Panasonic Let's Note CF-XZ6 | Toughbook series |
| **CPU** | Intel® Core™ i5-7300U (Kaby Lake) | 2 Cores / 4 Threads |
| **iGPU** | Intel® HD Graphics 620 | Metal Supported |
| **RAM** | 8GB LPDDR3 | |
| **Storage** | 256GB SSD (macOS) + 500GB HDD | |
| **WLAN/BT** | Intel® Dual Band Wireless-AC 8265 | ITWM / BlueToolFixup |
| **Ethernet** | Realtek RTL8111 | Native Support |

---

## 🛠 Tình trạng hoạt động (Status)

### ✅ Hoạt động (Working)
- [x] **Graphics:** Intel HD 620 (Full Acceleration).
- [x] **I/O Ports:** USB-C, USB-A, HDMI, VGA hoạt động ổn định.
- [x] **Connectivity:** LAN, SD Card Slot hoạt động tốt.
- [x] **Display:** Touchscreen nhận diện đa điểm ổn định.
- [x] **Audio:** Realtek Audio (Internal Speakers & Jack).

### ⚠️ Chưa ổn định (Issues/Bugs)
- [ ] **Input:** Keyboard & Touchpad (Hoạt động không ổn định, thường xuyên mất nhận diện).
- [ ] **Camera:** Nhận diện ngẫu nhiên (Inconsistent).
- [ ] **Power Management:** Lỗi Wake from Sleep (Thường xuyên gặp lỗi màn hình đen sau khi ngủ).

---

## 📂 Lịch sử cập nhật (Changelog)
### Phiên bản: `PANA_CFXZ6_01`
* **SMBIOS:** MacBookPro14,1 (Tối ưu cho Kaby Lake).
* **Kexts:** Đã tích hợp AirportItlwm cho WiFi Intel 8265NGW.
* **Note:** Đây là phiên bản thử nghiệm ban đầu, chưa khuyến khích dùng làm máy làm việc chính (Daily Driver).

---

## 🚀 Hướng dẫn sử dụng
1. Fork hoặc Clone repository này.
2. Sao chép thư mục `EFI` vào phân vùng EFI của USB hoặc ổ cứng.
3. **Lưu ý:** Bạn cần tự tạo lại `Serial Number`, `Board Serial` và `SmUUID` bằng **GenSMBIOS** để tránh xung đột dịch vụ Apple.

## 📝 Kết luận
Dự án hiện vẫn đang trong giai đoạn phát triển và chưa hoàn thiện. Rất hoan nghênh các đóng góp (Pull Request) từ cộng đồng để xử lý triệt để lỗi Bàn phím/Touchpad trên dòng Toughbook này.

---
*I ❤️ Hackintosh Community.*
