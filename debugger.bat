@echo off
@setlocal enabledelayedexpansion
chcp 65001>nul
set line=
if not "%~x1"==".apl" msg "%username%" "O Arquivo está fora de compatibilidade APL. Ou com versões antigas do ApoloDOS e assim a arquitetura é incompativel"
for /f "delims=" %%a in ('type %1') do (
    set multiple=1
    call :getargs %%a
    set /a line+=1
    if "!arg1!"=="get-ip" (
        ::if not defined "arg2" echo ERRO, LINHA: !line! ARGUMENTO FALTANDO.
        call :getres curl http://meuip.com/api/meuip.php -s
        echo !debg!
    )
    if "!arg1!"=="say" (
        echo !all!
    )
    if "!arg1!"=="break" (
        pause
    )
    if "!arg1!"=="files" (
        echo.
        echo Arquivos:
        echo.
        dir /b
        echo.
    )
    if "!arg1!"=="set" (
        if not defined arg2 echo ERRO, LINHA: !line! ARGUMENTO FALTANDO.
        if not defined arg3 echo ERRO, LINHA: !line! ARGUMENTO FALTANDO.
        set deb[!arg2!]=!arg3!
    )
    if "!arg1!"=="kill" (
        if not defined arg2 echo ERRO, LINHA: !line! ARGUMENTO FALTANDO.
        taskkill /f /im !arg2!
    )
    if "!arg1!"=="start" (
        if not defined arg2 echo ERRO, LINHA: !line! ARGUMENTO FALTANDO.
        start !arg2!
    )
)
pause
:getargs
set all=
set count=1
for %%a in (%*) do (
    set arg!count!=%%a
    if not "!count!"=="1" set all=!all! %%a
    set /a count+=1
)
set all=!all:~1!
exit /b

:getres
for /f "delims=" %%a in ('%*') do set debg=%%a>nul
exit /b