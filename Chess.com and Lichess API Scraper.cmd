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
echo All input must be lowcase!
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

(for /f "usebackq tokens=2 delims=[]" %%g in (`curl https://api.chess.com/pub/player/%chess%/games/archives`) do (
    for %%h In (%%g) do curl "%%~h/pgn" >> Games.pgn
    )
)

:End
exit