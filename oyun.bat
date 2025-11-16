@echo off
chcp 65001 >nul
echo ============================
echo Toplu Python -> EXE builder
echo ============================
echo.

:: PyInstaller kontrol / yukleme
python -c "import PyInstaller" 2>nul
if %errorlevel% neq 0 (
  echo PyInstaller yüklü degil. Yukleniyor...
  python -m pip install --upgrade pip
  python -m pip install pyinstaller
  if %errorlevel% neq 0 (
    echo PyInstaller yuklenemedi. Manuel kurulum yapin: python -m pip install pyinstaller
    pause
    exit /b 1
  )
)

:: Her py dosyasi icin
for %%F in (*.py) do (
  echo Paketleniyor: %%F
  :: isme gore exe adi al (uzantisiz)
  set "NAME=%%~nF"
  call python -m PyInstaller --noconfirm --clean --onefile --windowed --name "%%~nF" "%%F"
  echo.
)

echo Tum dosyalar isleme alindi. EXE'ler dist klasorunde.
pause
