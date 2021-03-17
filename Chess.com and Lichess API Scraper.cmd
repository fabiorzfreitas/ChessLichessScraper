:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::             Chess.com and Lichess API Scraper               ::
::                  Author: fabiorzfreitas                     ::
:: Extract all games from a player from Chess.com and Lichess  ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: This tool uses Chess.com and Lichess APIs to extract all games from a given player. ::

@echo off
setLocal enabledelayedexpansion

echo.
echo.
echo.
echo You can skip the input bellow by pressing Enter
echo.
echo.
echo.
set /p lichess="Input Lichess nickname and press Enter: "
set /p chess="Input Chess.com nickname and press Enter: "
echo.

:Lichess
if not defined lichess goto :Chess

curl https://lichess.org/api/games/user/%lichess% >> Games.pgn

:Chess
if not defined chess goto :End

curl https://api.chess.com/pub/player/%chess%/games/archives > input.txt

for /f "delims=" %%a in (input.txt) do (
    for %%b in (%%a) do (
	set string=%%b
	set "string=!string:[=,!"
    set "string=!string:]=,!" 
	echo !string! >> replaced.txt
	)
)

for /f "delims=" %%c in (replaced.txt) do (
    for %%d in (%%c) do (
	echo %%~d >> echo.txt
	)
)

for /f %%e in (echo.txt) do echo curl %%~e/pgn|find "." >> curllist.cmd

call curllist.cmd >> Games.pgn

del input.txt
del replaced.txt
del echo.txt
del curllist.cmd


:End
exit