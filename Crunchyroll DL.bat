@echo off

echo         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.   /                                     \
echo    /                                     \
echo.   /       CrunchyRoll DL                \
echo    /                                     \
echo    /                                     \
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo.
echo.
echo.	


:settings
for /f "tokens=1,2 delims==" %%a in (settings.ini) do (
if %%a==Username set Username=%%b
if %%a==Password set Password=%%b
if %%a==Quality set Quality=%%b
if %%a==LanguageCode set LanguageCode=%%b
)

goto :main

:main
set /p dlUrl="Paste CrunchyRoll URL: "
echo .
"%~dp0\MD\youtubedl.exe" %dlURL% -u %Username% -p %Password% -f best[height=%Quality%] --sub-lang %LanguageCode% --write-sub

echo.
echo.
echo ~~~~~~~~~~~~~~~~
echo.


echo Moving \ Remuxing

for %%A in (*.flv) do ( ".\MD\ffmpeg.exe" -i "%~dp0\%%~nxA" -i "%~dp0\%%~nA.%LanguageCode%.ass" -map 0:v -map 0:a -c copy -map 1 -c:s:0 ass -metadata:s:s:0 language=eng "Output\%%~nA.mkv" 
del "%~dp0\%%~nxA" 
)

for %%A in (*.mp4) do ( ".\MD\ffmpeg.exe" -i "%~dp0\%%~nxA" -i "%~dp0\%%~nA.%LanguageCode%.ass" -map 0:v -map 0:a -c copy -map 1 -c:s:0 ass -metadata:s:s:0 language=eng "Output\%%~nA.mkv" 
del "Output\%%~nxA"
IF EXIST "Output\%%~nA.mkv" goto :clean 
)

for %%A IN (*.mp4) do ( ".\MD\ffmpeg.exe" -i "%~dp0\%%~nxA" -c copy "Output\%%~nxA" )


	

:clean
IF EXIST "%~dp0\*.flv" del "%~dp0\*.flv"
IF EXIST "%~dp0\*.mp4" del "%~dp0\*.mp4"
IF EXIST "%~dp0\*.ass" del "%~dp0\*.ass"
goto :choice




:choice
set /P q=Would you like to Download another Series or Episode? [y/n] :
if /I "%q%" EQU "y" goto :settings
if /I "%q%" EQU "n" goto :done

echo.
echo.
echo.
echo.
echo.

:done



