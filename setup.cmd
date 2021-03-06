@echo off
pushd %~dp0
git submodule update --init

if defined VSINSTALLDIR (
   set _vcvarsall="%VSINSTALLDIR%VC\vcvarsall.bat"
) else (
   set _vcvarsall="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
)

if not exist %_vcvarsall% (
   set _vcvarsall="C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat"
   if not exist %_vcvarsall% (
      echo Failed to locate vcvarsall.bat!
      pause
      exit /b 1
   )
)

call %_vcvarsall% x64
copy /Y vc_win.ninja build.ninja
ninja -f vc_win.ninja externals!
popd
