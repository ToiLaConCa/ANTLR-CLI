# ANTLR CLI 🚀 (Easier to use)

> **Universal ANTLR 4 Toolkit & Automation CLI for Windows, Linux & macOS**  
> **Tag:** `#toolbyphichxivnuk` | **Version:** `2.1`  
> *Make ANTLR 4 easier to install, compile, debug and visualize on ANY operating system!*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-brightgreen.svg)]()
[![ANTLR Version](https://img.shields.io/badge/ANTLR-4.13.2-orange.svg)](https://www.antlr.org/)
[![Tool Tag](https://img.shields.io/badge/Tag-%23toolbyphichxivnuk-purple.svg)]()

---

## 🌟 Vì sao nên dùng ANTLR CLI? (Easier to use)

Việc cài đặt ANTLR 4 và runtime C++/Java trên cả Windows lẫn Linux thường rất rắc rối với người mới: phải tự tải file JAR, chỉnh sửa biến môi trường thủ công (`CLASSPATH`), viết file `.bat` / `.sh` wrapper...

**ANTLR CLI (`#toolbyphichxivnuk`)** sinh ra để biến toàn bộ quy trình đó thành **1 lệnh duy nhất trên mọi hệ điều hành**:
* ⚡ **Tự động kiểm tra & cài đặt phụ thuộc (Auto-Installer):**
  * Trên **Windows**: Tự động dùng `winget` cài JDK nếu máy chưa có.
  * Trên **Linux**: Tự động nhận diện distro (Fedora `dnf`, Arch/CachyOS `pacman`, Ubuntu/Debian `apt`) để cài JDK, CMake, g++, make.
  * Trên **macOS**: Hỗ trợ cài đặt nhanh qua Homebrew.
* 📦 **Tích hợp sẵn trọn gói:** Bao gồm đầy đủ `antlr-4.13.2-complete.jar` và runtime C++ chính thức.
* 🛠️ **Bộ lệnh CLI thống nhất:** Tự động tạo các lệnh `antlr4`, `grun`, `helpantlr` chạy mượt mà trên cả CMD, PowerShell và Bash/Zsh.
* 🎯 **Không sợ nhầm lẫn giữa các hệ điều hành:** Có sẵn bảng so sánh phím tắt và trình soạn thảo cho từng OS.

---

## ⚡ 1. Cài đặt siêu nhanh theo hệ điều hành (Quick Install)

<details open>
<summary><b>🪟 Dành cho Windows (PowerShell)</b></summary>
<br>

Mở **PowerShell** và chạy 2 dòng sau:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\install.ps1
```

*(Script sẽ tự kiểm tra `winget`, cài JDK nếu thiếu, thiết lập `antlr4.cmd`, `grun.cmd` và tự động lưu vào User `PATH`).*

> 💡 **Lưu ý:** Sau khi cài đặt xong, hãy tắt và mở lại cửa sổ PowerShell/CMD mới để Windows nhận diện lệnh `antlr4` và `grun`.
</details>

<details>
<summary><b>🐧 Dành cho Linux (Arch / CachyOS / Fedora / Ubuntu / Debian)</b></summary>
<br>

Mở **Terminal** và chạy:

```bash
bash install.sh
source ~/.config/antlr/env.sh
```

*(Script sẽ tự động quét các gói còn thiếu và gọi trình quản lý gói tương ứng của hệ thống để cài đặt).*
</details>

<details>
<summary><b>🍎 Dành cho macOS</b></summary>
<br>

Mở **Terminal** và cài đặt nhanh qua Homebrew:

```bash
brew install openjdk antlr
```
</details>

---

## 🎯 2. Bảng tra cứu khác biệt thực chiến (Cheat Sheet)

Để không bị bỡ ngỡ khi chuyển đổi giữa Windows và Linux/macOS, hãy tham khảo bảng so sánh dưới đây:

| Tác vụ | 🐧 Linux / 🍎 macOS | 🪟 Windows |
| :--- | :--- | :--- |
| **Soạn file ngữ pháp** | `nano Hello.g4` (hoặc `vim`) | `notepad Hello.g4` (hoặc `code Hello.g4`) |
| **Biên dịch ngữ pháp** | `antlr4 Hello.g4` | `antlr4 Hello.g4` |
| **Biên dịch Java** | `javac Hello*.java` | `javac Hello*.java` |
| **Xem danh sách Token** | `grun Hello r -tokens` | `grun Hello r -tokens` |
| **Mở cây cú pháp đồ họa (GUI)** | `grun Hello r -gui` | `grun Hello r -gui` |
| **Kết thúc gõ input thủ công ⚠️** | Nhấn **Enter** rồi ấn **`Ctrl + D`** | Nhấn **Enter** rồi ấn **`Ctrl + Z`** (rồi Enter) |
| **Cách truyền input AN TOÀN NHẤT ⭐** | `grun Hello r -gui < input.txt` | `grun Hello r -gui < input.txt` |

> ⭐ **Mẹo vàng cho người mới:** Thay vì gõ input trực tiếp trong terminal rồi loay hoay ấn `Ctrl+D` hay `Ctrl+Z`, bạn chỉ cần tạo file `input.txt` chứa nội dung cần kiểm thử và dùng cú pháp `< input.txt`. Cách này hoạt động hoàn hảo 100% trên cả Windows, Linux và macOS!

---

## 📖 3. Hướng dẫn sử dụng từng bước (Step-by-step)

Bạn có thể gõ lệnh sau bất kỳ lúc nào để xem hướng dẫn trực quan:
```bash
helpantlr
# hoặc:
antlr4 -helpantlr
```

### Bước 1: Soạn file Ngữ pháp (`.g4`)
* **Trên Linux/macOS:** `nano Hello.g4`
* **Trên Windows:** `notepad Hello.g4`

Dán nội dung ngữ pháp cơ bản:
```antlr4
grammar Hello;

// Parser Rule (bắt đầu bằng chữ thường):
r : 'hello' ID ;

// Lexer Rules (bắt đầu bằng chữ IN HOA):
ID : [a-zA-Z]+ ;
WS : [ \t\r\n]+ -> skip ;
```

> 💡 **Mẹo:** Gõ `helpantlr --example` (trên Linux) để tự động sinh sẵn file mẫu `Hello.g4`!

### Bước 2: Biên dịch file `.g4`
```bash
antlr4 Hello.g4
```

### Bước 3: Biên dịch mã Java sinh ra
```bash
javac Hello*.java
```

### Bước 4: Kiểm thử cây cú pháp trực quan
```bash
grun Hello r -gui
```
Nhập `hello world` rồi kết thúc input (hoặc truyền qua file `< input.txt`), cửa sổ Parse Tree đồ họa tuyệt đẹp sẽ xuất hiện!

---

## 📂 4. Cấu trúc Repository

```text
ANTLR-CLI/
├── bin/
│   ├── antlr4            # Wrapper Linux/macOS
│   ├── antlr4.cmd        # Wrapper Windows CMD/PowerShell
│   ├── grun              # TestRig Linux/macOS
│   ├── grun.cmd          # TestRig Windows CMD/PowerShell
│   ├── helpantlr         # Interactive Help Linux/macOS
│   └── helpantlr.cmd     # Interactive Help Windows
├── examples/             # Các ví dụ mẫu (Tokens, Calculator, CIdentifier)
├── jar/
│   └── antlr-4.13.2-complete.jar
├── runtime-cpp/          # Mã nguồn C++ Runtime 4.13.2
├── install.sh            # Trình cài đặt tự động cho Linux/macOS
├── install.ps1           # Trình cài đặt tự động cho Windows (PowerShell + winget)
├── test.sh               # Bộ kiểm thử tự động
└── README.md
```

---

## 🏷️ 5. Tác giả & Bản quyền
* **Phát triển & Đóng gói:** phichxi (`#toolbyphichxivnuk`)
* **Khẩu hiệu:** *ANTLR CLI — Easier to use on Windows, Linux & macOS!*
* **Dựa trên:** ANTLR 4.13.2 chính thức của Terence Parr và cộng đồng ANTLR.
