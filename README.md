# ANTLR CLI 🚀 (Easier to use)

> **Bộ công cụ tự động hóa ANTLR 4 đa nền tảng cho Windows, Linux & macOS**  
> **Tag:** `#toolbyphichxivnuk` | **Version:** `2.1.2`  
> *Giúp việc cài đặt, biên dịch, kiểm thử và trực quan hóa cây cú pháp ANTLR 4 trở nên dễ dàng nhất trên MỌI hệ điều hành!*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-brightgreen.svg)]()
[![ANTLR Version](https://img.shields.io/badge/ANTLR-4.13.2-orange.svg)](https://www.antlr.org/)
[![Tool Tag](https://img.shields.io/badge/Tag-%23toolbyphichxivnuk-purple.svg)]()

---

## 🌟 Vì sao nên dùng ANTLR CLI? (Easier to use)

Việc cài đặt ANTLR 4 và runtime C++/Java trên máy tính trước đây rất rắc rối đối với sinh viên và lập trình viên: phải tự tải file JAR từ trang chủ, chỉnh sửa biến môi trường `CLASSPATH` phức tạp, tự viết script wrapper `.bat` trên Windows hoặc `.sh` trên Linux...

**ANTLR CLI (`#toolbyphichxivnuk`)** sinh ra để biến toàn bộ quy trình đó thành **1 thao tác tự động trên cả 3 hệ điều hành**:
* ⚡ **Tự động quét & cài đặt phần mềm phụ thuộc (Auto-Installer):**
  * **Windows:** Tự động dùng `winget` cài Microsoft OpenJDK 21 nếu máy chưa có Java.
  * **Linux:** Tự động nhận diện distro (Arch/CachyOS dùng `pacman`, Fedora dùng `dnf`, Ubuntu/Debian dùng `apt`, openSUSE dùng `zypper`) để cài JDK, CMake, g++, make.
  * **macOS:** Hỗ trợ cài đặt tự động qua Homebrew.
* 📦 **Tích hợp trọn gói:** Đã bao gồm sẵn `antlr-4.13.2-complete.jar` và mã nguồn C++ runtime chính thức.
* 🛠️ **Bộ lệnh CLI thống nhất:** Cung cấp sẵn các lệnh `antlr4`, `grun`, `helpantlr` hoạt động mượt mà trên cả CMD, PowerShell, Bash và Zsh.
* 🧭 **Hướng dẫn cầm tay chỉ việc:** Tích hợp sẵn lệnh `-helpantlr` chỉ dẫn quy trình từ lúc viết ngữ pháp đến lúc mở cây cú pháp GUI.

---

## ⚡ 1. Hướng dẫn cài đặt chi tiết cho 3 hệ điều hành

<details open>
<summary><b>🪟 DÀNH CHO WINDOWS (Windows 10, 11)</b></summary>
<br>

### Cách A: Cài đặt siêu tốc 1 dòng lệnh (Khuyên dùng - Không cần cài Git)
Mở cửa sổ **PowerShell** và dán duy nhất 1 dòng lệnh sau:

```powershell
irm https://raw.githubusercontent.com/ToiLaConCa/ANTLR-CLI/main/install.ps1 | iex
```

*(Script sẽ tự động kiểm tra `winget`, tự cài Java OpenJDK nếu thiếu, tải ANTLR 4.13.2, tạo các lệnh `antlr4.cmd`, `grun.cmd`, `helpantlr.cmd` và tự lưu vào `PATH` của Windows).*

---

### Cách B: Clone repository về máy (Dành cho ai muốn xem mã nguồn mẫu)
Mở **PowerShell** và thực hiện lần lượt các lệnh:

```powershell
git clone https://github.com/ToiLaConCa/ANTLR-CLI.git
cd ANTLR-CLI
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\install.ps1
```

> ⚠️ **LƯU Ý QUAN TRỌNG TRÊN WINDOWS:**  
> Sau khi cài đặt hoàn tất, **hãy tắt hẳn cửa sổ PowerShell/CMD và mở lại cửa sổ mới** để Windows nạp lại biến môi trường `PATH`.
</details>

<details>
<summary><b>🐧 DÀNH CHO LINUX (Ubuntu, Debian, Fedora, Arch Linux, CachyOS, openSUSE)</b></summary>
<br>

### Cách A: Cài đặt tự động qua Git Clone
Mở **Terminal** và chạy các lệnh:

```bash
git clone https://github.com/ToiLaConCa/ANTLR-CLI.git
cd ANTLR-CLI
bash install.sh
```

### Cách B: Nạp ngay biến môi trường vào terminal hiện tại
Sau khi script chạy xong, gõ lệnh sau để nhận diện lệnh ngay lập tức:

```bash
source ~/.config/antlr/env.sh
```
*(File cấu hình cũng đã được tự động thêm vào `~/.bashrc` và `~/.zshrc`, lần sau mở máy sẽ tự nhận diện).*
</details>

<details>
<summary><b>🍎 DÀNH CHO MACOS (Apple Silicon M1/M2/M3 & Intel Mac)</b></summary>
<br>

### Cách A: Cài đặt chuẩn qua Homebrew (Khuyên dùng nhất trên macOS)
Mở **Terminal** và chạy:

```bash
# 1. Cài đặt Java và ANTLR qua Homebrew
brew install openjdk antlr

# 2. Thiết lập alias lệnh antlr4 và grun vào shell của bạn (~/.zshrc)
echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc
echo 'alias antlr4="antlr"' >> ~/.zshrc
echo 'alias grun="antlr-test"' >> ~/.zshrc
source ~/.zshrc
```

### Cách B: Dùng bộ script ANTLR-CLI
Nếu máy bạn đã có sẵn Java:
```bash
git clone https://github.com/ToiLaConCa/ANTLR-CLI.git
cd ANTLR-CLI
bash install.sh --skip-deps
source ~/.config/antlr/env.sh
```
</details>

---

## 🔍 2. KHÂU KIỂM TRA BẮT BUỘC SAU KHI CÀI ĐẶT (Health Check)

Sau khi cài đặt xong, hãy mở một cửa sổ Terminal (hoặc PowerShell mới) và chạy lần lượt các lệnh sau để kiểm tra:

### Bảng lệnh kiểm tra nhanh:

| Lệnh kiểm tra | Kết quả mong đợi (Output chuẩn) | Ý nghĩa |
| :--- | :--- | :--- |
| **`java -version`** | `openjdk version "21.x.x"` (hoặc 11, 17, 21+) | Môi trường máy ảo Java đã sẵn sàng |
| **`javac -version`** | `javac 21.x.x` (hoặc tương ứng) | Trình biên dịch mã Java đã sẵn sàng |
| **`antlr4`** | `ANTLR Parser Generator  Version 4.13.2` | Trình biên dịch ngữ pháp ANTLR đã sẵn sàng |
| **`grun`** | `java org.antlr.v4.gui.TestRig GrammarName startRuleName ...` | Công cụ TestRig kiểm thử cây cú pháp đã sẵn sàng |
| **`helpantlr`** | Hiển thị Banner **`#toolbyphichxivnuk - Easier to use`** | Bảng hướng dẫn tương tác độc quyền hoạt động tốt |

### 🛠️ Xử lý sự cố nếu không nhận diện lệnh (Troubleshooting):
* **Trên Windows:** Nếu gõ `antlr4` mà báo `'antlr4' is not recognized`:
  * *Nguyên nhân:* Bạn chưa tắt terminal cũ đi mở lại.
  * *Cách sửa:* Đóng hoàn toàn cửa sổ PowerShell/CMD đang mở, bật cửa sổ mới lên là lệnh sẽ được nhận diện.
* **Trên Linux / macOS:** Nếu báo `command not found`:
  * *Cách sửa:* Chạy ngay lệnh `source ~/.config/antlr/env.sh` hoặc khởi động lại terminal.

---

## 🎯 3. Bảng tra cứu khác biệt thực chiến giữa các hệ điều hành

| Thao tác thực tế | 🐧 Linux / 🍎 macOS | 🪟 Windows |
| :--- | :--- | :--- |
| **Trình soạn thảo ngữ pháp** | `nano Hello.g4` (hoặc `vim`) | `notepad Hello.g4` (hoặc `code Hello.g4`) |
| **Lệnh biên dịch ngữ pháp** | `antlr4 Hello.g4` | `antlr4 Hello.g4` |
| **Lệnh biên dịch Java** | `javac Hello*.java` | `javac Hello*.java` |
| **Xem danh sách Token** | `grun Hello r -tokens` | `grun Hello r -tokens` |
| **Hiển thị cây cú pháp đồ họa (GUI)** | `grun Hello r -gui` | `grun Hello r -gui` |
| **Ký tự kết thúc nhập thủ công ⚠️** | Nhấn **Enter** rồi ấn **`Ctrl + D`** | Nhấn **Enter** rồi ấn **`Ctrl + Z`** (rồi Enter) |
| **MẸO CHỐNG LỖI INPUT AN TOÀN NHẤT ⭐** | `grun Hello r -gui < input.txt` | `grun Hello r -gui < input.txt` |

> ⭐ **Mẹo vàng cho người mới:** Khi dùng lệnh `grun`, việc gõ input trực tiếp trong terminal rất dễ bị lỗi phím tắt kết thúc (`Ctrl+D` trên Linux hay `Ctrl+Z` trên Windows). Bạn chỉ cần tạo sẵn một file text `input.txt` và truyền bằng dấu `< input.txt`, cây cú pháp sẽ mở lên ngay lập tức mà không bao giờ lo bấm nhầm phím!

---

## 📖 4. Hướng dẫn thực hành từng bước từ A - Z (Walkthrough)

Bạn có thể gõ lệnh sau trong terminal để xem hướng dẫn trực quan bất kỳ lúc nào:
```bash
helpantlr
# hoặc:
antlr4 -helpantlr
```

### Bước 1: Soạn file Ngữ pháp mẫu (`Hello.g4`)
* **Trên Linux/macOS:** `nano Hello.g4`
* **Trên Windows:** `notepad Hello.g4`

Nội dung file:
```antlr4
grammar Hello;

// Parser Rule (bắt đầu bằng chữ thường):
r : 'hello' ID ;

// Lexer Rules (bắt đầu bằng chữ IN HOA):
ID : [a-zA-Z]+ ;
WS : [ \t\r\n]+ -> skip ;
```
*(💡 Mẹo: Trên Linux, bạn có thể gõ `helpantlr --example` để tự động tạo file mẫu mà không cần chép tay).*

### Bước 2: Biên dịch ngữ pháp `.g4` sang mã nguồn
```bash
antlr4 Hello.g4
```
*(Hệ thống sẽ tự động sinh ra các file: `HelloLexer.java`, `HelloParser.java`, `HelloListener.java`...)*

### Bước 3: Biên dịch các file Java sinh ra
```bash
javac Hello*.java
```

### Bước 4: Kiểm thử cây cú pháp trực quan
Tạo một file kiểm thử `input.txt` chứa dòng chữ:
```text
hello world
```
Sau đó chạy lệnh mở giao diện đồ họa GUI:
```bash
grun Hello r -gui < input.txt
```
Một cửa sổ hiển thị cây phân tích cú pháp (Parse Tree) trực quan sinh động sẽ xuất hiện ngay trước mắt bạn!

---

## 🧪 5. Bộ kiểm thử tự động (Automated Test Suite)

Để kiểm tra toàn diện cả Java lẫn C++ runtime trên máy bạn xem có đạt chuẩn hay không:

```bash
bash test.sh
```

Kết quả mong đợi: `Ket qua: 6 dat, 0 loi` (đã test thành công 100% các bài toán tokens, calculator và identifier).

---

## 📂 6. Cấu trúc Repository

```text
ANTLR-CLI/
├── bin/
│   ├── antlr4            # Script wrapper cho Linux/macOS
│   ├── antlr4.cmd        # Script wrapper cho Windows CMD/PowerShell
│   ├── grun              # TestRig cho Linux/macOS
│   ├── grun.cmd          # TestRig cho Windows CMD/PowerShell
│   ├── helpantlr         # Lệnh trợ giúp tương tác độc quyền Linux/macOS
│   └── helpantlr.cmd     # Lệnh trợ giúp tương tác độc quyền Windows
├── examples/             # Các thư mục bài tập & ngữ pháp mẫu (Tokens, Calculator, CIdentifier)
├── jar/
│   └── antlr-4.13.2-complete.jar
├── runtime-cpp/          # Toàn bộ mã nguồn C++ Runtime 4.13.2 chính thức
├── install.sh            # Trình cài đặt tự động đa nền tảng cho Linux/macOS
├── install.ps1           # Trình cài đặt tự động cho Windows (PowerShell + winget)
├── test.sh               # Bộ kịch bản tự động kiểm thử toàn hệ thống
└── README.md
```

---

## 🏷️ 7. Tác giả & Bản quyền
* **Phát triển & Đóng gói:** phichxi (`#toolbyphichxivnuk`)
* **Khẩu hiệu:** *ANTLR CLI — Easier to use on Windows, Linux & macOS!*
* **Dựa trên:** ANTLR 4.13.2 chính thức của Terence Parr và cộng đồng ANTLR.
