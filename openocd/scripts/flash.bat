::
:: Copyright (c) 2020 KNpTrue
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.
::

@echo off

:: %1: interface
:: %2: target
:: %3: image path
:: %4: base addr

if "%1" == "" goto printHelp
if "%2" == "" goto printHelp
if "%3" == "" goto printHelp
if "%4" == "" goto printHelp

openocd -f %1 -f %2^
        -c "init"^
        -c "targets"^
        -c "reset halt"^
        -c "flash probe 0"^
        -c "flash write_image erase %3 %4"^
        -c "reset halt"^
        -c "verify_image %3 %4"^
        -c "reset run"^
        -c "shutdown"
if %ERRORLEVEL% EQU 0 echo Flash successfully.
exit %ERRORLEVEL%

:printHelp
echo Command usage:
echo     %0 [interface] [target] [image path] [base address]
