@echo off
chcp 65001 >nul
echo ==================================================================
echo   █████╗ ███╗   ██╗████████╗██╗     ██████╗      ██████╗██╗     ██╗
echo  ██╔══██╗████╗  ██║╚══██╔══╝██║     ██╔══██╗    ██╔════╝██║     ██║
echo  ███████║██╔██╗ ██║   ██║   ██║     ██████╔╝    ██║     ██║     ██║
echo  ██╔══██║██║╚██╗██║   ██║   ██║     ██╔══██╗    ██║     ██║     ██║
echo  ██║  ██║██║ ╚████║   ██║   ███████╗██║  ██║    ╚██████╗███████╗██║
echo  ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝     ╚═════╝╚══════╝╚═╝
echo  >> ANTLR CLI for Windows -- Easier to use!
echo  >> Tag: #toolbyphichxivnuk
echo ==================================================================
echo.
echo HUONG DAN SU DUNG ANTLR CLI TREN WINDOWS:
echo.
echo [BUOC 1] Tao file ngu phap (.g4) bang Notepad hoac VS Code:
echo   notepad Hello.g4
echo.
echo [BUOC 2] Bien dich file .g4 sang ma nguon Java:
echo   antlr4 Hello.g4
echo.
echo [BUOC 3] Bien dich cac file Java sinh ra:
echo   javac Hello*.java
echo.
echo [BUOC 4] Kiem thu cay cu phap bang TestRig (grun):
echo   * Xem danh sach Token:
echo       grun Hello r -tokens
echo       (Go chu 'hello world', sau do an Ctrl + Z roi an Enter de ket thuc)
echo.
echo   * Xem cay cu phap truc quan (Cua so do hoa GUI):
echo       grun Hello r -gui
echo.
echo   * Cach truyen file input truc tiep (Khuyen dung, khong lo bam nham Ctrl+Z):
echo       grun Hello r -gui ^< input.txt
echo ==================================================================
