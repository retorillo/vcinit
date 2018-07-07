@echo off
setlocal enabledelayedexpansion
set msvs=Microsoft Visual Studio
set vshive=HKLM\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7
set vsvers=15.0;14.0;

set idedir=
set vsdir=
set vcdir=
set vcvarsall=

:search
  set count=1
  :search_loop
  set vsver=
  for /f "tokens=%count% delims=;^ eol=" %%d in ("%vsvers%") do set vsver=%%d
  if "!vsver!"=="" goto error
  set regquery=reg query %vshive% /v !vsver! && !regquery! 2> NUL > NUL
  if errorlevel 1 set /a count=count+1 && goto search_loop
  for /f "usebackq skip=1 tokens=2,* delims= " %%d in (`!regquery!`) do set vsdir=%%e
  set vcdir=!vsdir!VC\
  cd /D !vcdir!
  for /f "delims=" %%d in ('dir /D /B /S vcvarsall.bat') do (set vcvarsall=%%d) && goto apply
  if "!vcvarsall!"=="" goto error

:apply
  for /f "tokens=1-4 delims=;^ eol=" %%a in ("!vcdir!;!vcvarsall!;!vsdir!;!vsver!") do (
    endlocal
    set __VC_DIR=%%a
    set __VCVARSALL=%%b
    set __VS_DIR=%%c
    set __VSVERSION=%%d
    goto end
  )

:error
  endlocal
  exit /b 1

:end
  echo on
  call "%__VCVARSALL%" %*
