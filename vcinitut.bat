@echo off
setlocal enabledelayedexpansion
call vcinit %*
if not defined __VC_DIR goto error

set utdirs=UnitTest\;Auxiliary\VS\UnitTest\;
:search
  set count=0
  :search_loop
  set /a count=count+1
  set utdir=
  for /f "tokens=%count% delims=;^ eol=" %%d in ("%utdirs%") do set utdir=%%d
  if "!utdir!"=="" goto error
  if not exist "!__VC_DIR!!utdir!" goto search_loop

:apply
  
  for /f "tokens=1 delims=;^ eol=" %%a in ("!__VC_DIR!!utdir!;") do (
  for /f "tokens=1 delims=^ eol=" %%i in ("!INCLUDE!") do (
  for /f "tokens=1 delims=^ eol=" %%l in ("!LIB!") do (
      endlocal
      set INCLUDE=%%i;%%a^include
      set LIB=%%l;%%a^lib
      echo [vcinitut.bat] %%a^include
      echo [vcinitut.bat] %%a^lib
      goto end
  )))
:error
  endlocal
  exit /b 1

:end
  echo on
