# vcinit

Helps to promote vanilla Command Prompt to Visual Studio Tools Command Prompt by
invoking C++ development environment configurator (vcvarsall).

`vcinit` automatically detect latest Visual Studio on your machine, and invoke
`vcvarsall.bat`.

`vcinitut` is extended script to configure Visual Studio Unit Test Framework
header and library directories.

Run `vcinit` or `vcinitut` as follows:

```bat
vcinit x86 8.1
vcinitut x64
```

These script enables the following special variables:

- `__VCVARSALL` (eg: `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat`)
- `__VS_DIR` (eg: `C:\Program Files (x86)\Microsoft Visual Studio 14.0\`)
- `__VC_DIR` (eg: `C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC`)
- `__VS_VER` (eg: `14.0`)

## Prerequisuite

- Visual Studio 2017 or 2015
- x64 machine

## License

CC0 1.0

No Rights Reserved
