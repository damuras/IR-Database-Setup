:: ---------------------------------------------------------------------------------------
:: This source file is for the Tabula Rasa emulator project
:: 
:: ---------------------------------------------------------------------------------------
:: This library is free software; you can redistribute it and/or
:: modify it under the terms of the GNU Lesser General Public
:: License as published by the Free Software Foundation; either
:: version 2.1 of the License, or (at your option) any later version.
:: 
:: This library is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
:: Lesser General Public License for more details.
:: 
:: You should have received a copy of the GNU Lesser General Public
:: License along with this library; if not, write to the Free Software
:: Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
:: ---------------------------------------------------------------------------------------


:: -- Prepare the Command Processor
	SETLOCAL ENABLEEXTENSIONS
	SETLOCAL ENABLEDELAYEDEXPANSION
	--MODE con:cols=72 lines=38

:: Set initial VARS
	SET db_user=----
	SET db_pass=----
	SET db_host=----
	SET "PROJECT_BASE=%~dp0"

:: Set the window title 
SET title=TR Database setup
TITLE %title%

::
:: Start
::

@ECHO OFF
	CALL:READ_CFG
	CALL:ScreenIntro
	CALL:MainMenu

::
:: Functions
::

:READ_CFG
	FOR /F "tokens=2 delims==" %%a IN ('find "username" ^< setup.cfg') DO SET db_user=%%a
	FOR /F "tokens=2 delims==" %%a IN ('find "password" ^< setup.cfg') DO SET db_pass=%%a
	FOR /F "tokens=2 delims==" %%a IN ('find "host" ^< setup.cfg') DO SET db_host=%%a


@ECHO OFF

:MainMenu
	CLS

ECHO.                              
ECHO. ----------------------------------------------------------------------
ECHO.  DB IP: %db_host%     DB Username: %db_user%    DB Password: %db_pass%
ECHO. ----------------------------------------------------------------------
ECHO.                                   ^|
ECHO.          Database Setup           ^|       Database Maintenance
ECHO.                                   ^|
ECHO.   (1) Complete DB Install         ^|  (a) Complete Database Backup
ECHO.                                   ^|  (b) Delete Databases
ECHO.       Individual DB Setup         ^|
ECHO.                                   ^|
ECHO.   (2) TR_Auth_Server              ^|  
ECHO.   (3) TR_Game_Server              ^|  
ECHO.   (-) -------------               ^|  
ECHO.                                   ^|  
ECHO.        Server Configuration       ^|  
ECHO.                                   ^|
ECHO.   (-) -------------------         ^|               Help
ECHO.   (-) -------------------         ^|
ECHO.   (-) -------------------         ^|  (h) Help
ECHO.   (-) -------------------         ^|  (s) Stats
ECHO.                                   ^|
ECHO. ----------------------------------------------------------------------
SET /P Selection=Make a selection or ^(q^) quit : 

IF /I '%Seletion%'=='1' GOTO :DBFull
IF /I '%Seletion%'=='2' GOTO :TR_Auth
IF /I '%Seletion%'=='3' GOTO :TR_Game
IF /I '%Seletion%'=='c' GOTO :Backup
IF /I '%Seletion%'=='d' GOTO :DBremove 
IF /I '%Seletion%'=='h' GOTO :Stats
IF /I '%Seletion%'=='q' GOTO :exit

GOTO:MainMenu

:DBFull
	CALL:ScreenClear
	CALL:ShortMenu
	ECHO.			Full Database Install Started
	ECHO.
	ECHO.				* Please Wait *