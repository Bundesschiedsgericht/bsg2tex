@echo off

rem 3compile, Version vom 09. Juli 2013
rem CC-BY Markus Gerstel

rem Aufruf: 3compile.cmd "C:\Dokumente und Einstellungen\...\bsg-2013-02-12.tex"
rem Oder: Drag&Drop der .tex-Datei auf 3compile.cmd

rem Es werden 3 PDF-Dateien erstellt:
rem   -anonym.pdf    Gekürzte/Anonymisierte Fassung
rem   -print.pdf     Druckfassung für Briefpapier
rem   -volltext.pdf  Ungekürzte Fassung für Verfahrensbeteiligte

rem Da Dateien nicht überschrieben werden können, wenn sie offen sind, wird
rem wärend dem Bau der PDF-Dateien von der Verwendung von z.B. Acrobat Reader
rem abgeraten.
rem Das Script läuft aber wunderbar zusammen mit z.B. SumatraPDF. Das zeigt
rem dann auch quasi live Änderungen an, während im Hintergrund LaTeX rumlatext.

if exist "%~d1%~p1%~n1-volltext.tex" goto skipvt
echo \documentclass{bsg2tex} > "%~d1%~p1%~n1-volltext.tex"
echo \input{%~n1} >> "%~d1%~p1%~n1-volltext.tex"
:skipvt
if exist "%~d1%~p1%~n1-anonym.tex" goto skipan
echo \documentclass[anonym]{bsg2tex} > "%~d1%~p1%~n1-anonym.tex"
echo \input{%~n1} >> "%~d1%~p1%~n1-anonym.tex"
:skipan
if exist "%~d1%~p1%~n1-print.tex" goto skippr
echo \documentclass[print]{bsg2tex} > "%~d1%~p1%~n1-print.tex"
echo \input{%~n1} >> "%~d1%~p1%~n1-print.tex"
:skippr

rem pdflatex jeweils solange iterieren bis .aux-Datei konvergiert oder Fehler auftreten

echo.>"%~d1%~p1%~n1-volltext.aux.sec"
:vtprogress
if exist "%~d1%~p1%~n1-volltext.aux" copy "%~d1%~p1%~n1-volltext.aux" "%~d1%~p1%~n1-volltext.aux.sec"
pdflatex "%~d1%~p1%~n1-volltext.tex"
if ERRORLEVEL 1 goto endp
fc /b "%~d1%~p1%~n1-volltext.aux" "%~d1%~p1%~n1-volltext.aux.sec" > nul
if ERRORLEVEL 1 goto vtprogress
del "%~d1%~p1%~n1-volltext.aux.sec"
del "%~d1%~p1%~n1-volltext.log"
del "%~d1%~p1%~n1-volltext.tex"
del "%~d1%~p1%~n1-volltext.out"

echo.>"%~d1%~p1%~n1-anonym.aux.sec"
:anprogress
if exist "%~d1%~p1%~n1-anonym.aux" copy "%~d1%~p1%~n1-anonym.aux" "%~d1%~p1%~n1-anonym.aux.sec"
pdflatex "%~d1%~p1%~n1-anonym.tex"
if ERRORLEVEL 1 goto endp
fc /b "%~d1%~p1%~n1-anonym.aux" "%~d1%~p1%~n1-anonym.aux.sec" > nul
if ERRORLEVEL 1 goto anprogress
del "%~d1%~p1%~n1-anonym.aux.sec"
del "%~d1%~p1%~n1-anonym.log"
del "%~d1%~p1%~n1-anonym.tex"
del "%~d1%~p1%~n1-anonym.out"

echo.>"%~d1%~p1%~n1-print.aux.sec"
:prprogress
if exist "%~d1%~p1%~n1-print.aux" copy "%~d1%~p1%~n1-print.aux" "%~d1%~p1%~n1-print.aux.sec"
pdflatex "%~d1%~p1%~n1-print.tex"
if ERRORLEVEL 1 goto endp
fc /b "%~d1%~p1%~n1-print.aux" "%~d1%~p1%~n1-print.aux.sec" > nul
if ERRORLEVEL 1 goto prprogress
del "%~d1%~p1%~n1-print.aux.sec"
del "%~d1%~p1%~n1-print.log"
del "%~d1%~p1%~n1-print.tex"
del "%~d1%~p1%~n1-print.out"

goto end
:endp
pause
:end
