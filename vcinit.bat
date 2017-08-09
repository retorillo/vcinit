@echo off
setlocal enabledelayedexpansion
set msvs=Microsoft Visual Studio
set vshive=HKLM\SOFTWARE\Wow6432Node\Microsoft\VisualStudio
set vsvers=15.0;14.0;

set idedir=
set vcdir=
set vcvarsall=

:search_ide
  set count=1
  :search_ide_loop
  set vsver=
  for /f "tokens=%count% delims=;eol=" %%d in ("%vsvers%") do set vsver=%%d
  if "!vsver!"=="" goto error
  set regquery=reg query "%vshive%\!vsver!" /v InstallDir && !regquery! 2> NUL > NUL
  if errorlevel 1 set /a count=count+1 && goto search_ide_loop
  for /f "usebackq skip=1 tokens=2,* delims= " %%d in (`!regquery!`) do set idedir=%%e

:search_vc
  set count=1
  cd /D "!idedir!"
  :search_vc_loop
  for /f "delims=" %%d in ('cd') do (
    if "%vcdir%"=="%%~Fd" goto error
    set vcdir=%%~Fd
    for /f "tokens=1-3 delims= " %%e in ("%%~nxd") do if "%msvs%"=="%%e %%f %%g" (
      set vcdir=!vcdir!\VC
      cd !vcdir!
      for /f "delims=" %%d in ('dir /D /B /S vcvarsall.bat') do (set vcvarsall=%%d) && goto apply
      if "!vcvarsall!"=="" goto error
    )
    cd ..
  )
  goto search_vc_loop

:apply
  for /f "tokens=1-4 delims=;" %%a in ("!vcdir!;!vcvarsall!;!idedir!;!vsver!") do (
    endlocal
    set __VC_DIR=%%a
    set __VCVARSALL=%%b
    set __IDE_DIR=%%c
    set __VSVERSION=%%d
    goto end
  )

:error
  endlocal
  exit /b 1

:end
  echo on
  call "%__VCVARSALL%" %*
