# ==============================================================================
# ANTLR CLI - Universal Windows Installer (PowerShell)
# Tag: #toolbyphichxivnuk | Easier to use ANTLR on Windows
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Write-Host "
  █████╗ ███╗   ██╗████████╗██╗     ██████╗      ██████╗██╗     ██╗
 ██╔══██╗████╗  ██║╚══██╔══╝██║     ██╔══██╗    ██╔════╝██║     ██║
 ███████║██╔██╗ ██║   ██║   ██║     ██████╔╝    ██║     ██║     ██║
 ██╔══██║██║╚██╗██║   ██║   ██║     ██╔══██╗    ██║     ██║     ██║
 ██║  ██║██║ ╚████║   ██║   ███████╗██║  ██║    ╚██████╗███████╗██║
 ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝     ╚═════╝╚══════╝╚═╝
>> ANTLR CLI for Windows -- Easier to use!
>> Tag: #toolbyphichxivnuk
------------------------------------------------------------------" -ForegroundColor Green

$AntlrDir = "$env:USERPROFILE\antlr"
$BinDir = "$AntlrDir\bin"
$JarName = "antlr-4.13.2-complete.jar"
$JarDest = "$AntlrDir\$JarName"

# 1. Kiem tra Java (JDK) tren Windows
Write-Host "`n==> [1/4] Kiem tra Java JDK tren Windows..." -ForegroundColor Cyan
$JavaInstalled = $false
try {
    $javaVer = java -version 2>&1
    if ($LASTEXITCODE -eq 0 -or $javaVer -match "version") {
        $JavaInstalled = $true
        Write-Host "  [v] Java da san sang: $javaVer" -ForegroundColor Green
    }
} catch {
    $JavaInstalled = $false
}

if (-not $JavaInstalled) {
    Write-Host "  [!] Chua tim thay Java JDK. Tien hanh tu dong cai dat qua winget..." -ForegroundColor Yellow
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "  Dang goi winget de cai Microsoft OpenJDK 21..." -ForegroundColor Cyan
        winget install Microsoft.OpenJDK.21 --accept-package-agreements --accept-source-agreements --silent
        Write-Host "  [v] Da cai dat Microsoft OpenJDK thanh cong!" -ForegroundColor Green
    } else {
        Write-Host "  [x] Khong tim thay winget. Vui long cai JDK thu cong tai: https://adoptium.net/" -ForegroundColor Red
    }
}

# 2. Tao thu muc cai dat C:\Users\<Username>\antlr
Write-Host "`n==> [2/4] Thiet lap thu muc ANTLR tai $AntlrDir..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $BinDir | Out-Null

# 3. Copy hoac tai ve antlr-4.13.2-complete.jar
$CurrentScriptDir = ""
if ($MyInvocation.MyCommand.Path) {
    $CurrentScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}
$LocalJar = if ($CurrentScriptDir) { Join-Path $CurrentScriptDir "jar\$JarName" } else { "" }

if ($LocalJar -and (Test-Path $LocalJar)) {
    Copy-Item -Path $LocalJar -Destination $JarDest -Force
    Write-Host "  [v] Da sao chep $JarName tu kit cuc bo." -ForegroundColor Green
} else {
    Write-Host "  Dang tai $JarName tu server chinh thuc..." -ForegroundColor Cyan
    $JarUrl = "https://www.antlr.org/download/antlr-4.13.2-complete.jar"
    Invoke-WebRequest -Uri $JarUrl -OutFile $JarDest
    Write-Host "  [v] Da tai xong $JarName vao $AntlrDir." -ForegroundColor Green
}

# 4. Tao cac file CMD Wrapper: antlr4.cmd, grun.cmd, helpantlr.cmd
Write-Host "`n==> [3/4] Tao cac lenh CLI: antlr4, grun, helpantlr..." -ForegroundColor Cyan

# antlr4.cmd
$Antlr4Cmd = @"
@echo off
set "ANTLR_HOME=$AntlrDir"
for %%a in (%*) do (
  if "%%a"=="-helpantlr" (
    call helpantlr.cmd
    exit /b 0
  )
)
java -jar "%ANTLR_HOME%\$JarName" %*
"@
Set-Content -Path "$BinDir\antlr4.cmd" -Value $Antlr4Cmd -Encoding ASCII

# grun.cmd
$GrunCmd = @"
@echo off
set "ANTLR_HOME=$AntlrDir"
for %%a in (%*) do (
  if "%%a"=="-helpantlr" (
    call helpantlr.cmd
    exit /b 0
  )
)
java -cp "%ANTLR_HOME%\$JarName;." org.antlr.v4.gui.TestRig %*
"@
Set-Content -Path "$BinDir\grun.cmd" -Value $GrunCmd -Encoding ASCII

# helpantlr.cmd
$HelpCmd = @"
@echo off
echo ==================================================================
echo   ANTLR CLI -- Easier to use on Windows (#toolbyphichxivnuk)
echo ==================================================================
echo [BUOC 1] Tao file ngu phap bang Notepad:
echo   notepad Hello.g4
echo.
echo [BUOC 2] Bien dich ngu phap:
echo   antlr4 Hello.g4
echo.
echo [BUOC 3] Bien dich code Java:
echo   javac Hello*.java
echo.
echo [BUOC 4] Kiem thu cay cu phap bang TestRig:
echo   grun Hello r -tokens
echo   grun Hello r -gui
echo.
echo Meo: Nhap text, nhan Enter roi nhan Ctrl + Z (roi Enter) de ket thuc!
echo ==================================================================
"@
Set-Content -Path "$BinDir\helpantlr.cmd" -Value $HelpCmd -Encoding ASCII

# 5. Cap nhat User PATH
Write-Host "`n==> [4/4] Them $BinDir vao bien moi truong PATH cua Windows..." -ForegroundColor Cyan
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($CurrentPath -notlike "*$BinDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$CurrentPath;$BinDir", "User")
    Write-Host "  [v] Da them $BinDir vao PATH thanh cong!" -ForegroundColor Green
} else {
    Write-Host "  [v] $BinDir da co san trong PATH." -ForegroundColor Green
}

Write-Host "
==================================================================
 [HOAN TAT] Cai dat ANTLR CLI tren Windows thanh cong!
 Tag: #toolbyphichxivnuk -- Easier to use
==================================================================
Mo lai cua so PowerShell / CMD moi va go:
  helpantlr   (de xem huong dan)
  antlr4      (de bat dau bien dich)
" -ForegroundColor Green
