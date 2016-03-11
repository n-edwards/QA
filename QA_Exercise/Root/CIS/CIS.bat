@echo --------New Log--------                                                 >>%~dp0\output1.txt 2>&1
@echo Cloning repository...
@hg clone ..\..\Root  ..\..\Root_Clone                                        >>%~dp0\output1.txt 2>&1
@IF %errorlevel% NEQ 0 echo Clone unsuccessful. Check the log! Continuing may cause overwrites... & pause

@echo.                                                                       
@echo Clone complete. Moving to cloned repository...                         
@timeout /t 5

cd ..\..\Root_Clone                                                          

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Running compiler...                                                    
@timeout /t 5
cd Compiler
@IF NOT EXIST Compile.bat echo Compiler not found. Press any key to attempt to continue. & pause                                                            
@call Compile.bat                                                            >>%~dp0\output1.txt 2>&1
:: Might be a hassle to make our compiler produce bad output, since we're not using real code. To simplify, we can just pretend it failed, with:
::@IF NOT EXIST ..\BuildProducts\SuccessfulBuild.txt echo Build failed. Please close this process and correct source errors. & pause  

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Compilation complete. Logging updated executable info...               
@timeout /t 5
cd ..                                                                        
@hg diff                                                                     >>%~dp0\output1.txt 2>&1
:: Nothing is output if there is no difference.
@IF %errorlevel% NEQ 0 echo Unkown diff error. Check log and continue. & pause
:: hg diff's error level seems to be zero whether the files are different or not (bug?), so this handler is just an example for now.
::echo %errorlevel%
@timeout /t 5

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Committing new executable...                                           >>%~dp0\output1.txt 2>&1
hg commit -m "Committed updated exe to cloned repository."   
:: No output to log here (commits go to text files), so we just log the echo.                
@timeout /t 5

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Commit complete. Logging comparison to Root...
@timeout /t 5
@hg outgoing                                                                 >>%~dp0\output1.txt 2>&1
@IF %errorlevel% NEQ 0 echo Outgoing check didn't return 0. Compilation may have failed earlier. Press any key to attempt to continue. & pause 

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Pushing updated exe to original repository...
@timeout /t 5
@hg push ../Root                                                             >>%~dp0\output1.txt 2>&1
@IF %errorlevel% NEQ 0 echo Push didn't return 0. Root may already be updated. Press any key to attempt to continue. & pause 


@echo.                                                                       >> %~dp0\output1.txt 2>&1
@echo Heading back to Root to log push's new commit.
cd ../Root                                                                   
@timeout /t 5

@hg log                                                                      >>%~dp0\output1.txt 2>&1
@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Commit logged. Updating files...
@timeout /t 5

@hg update                                                                   >>%~dp0\output1.txt 2>&1
:: Also seems to be zero whether there's an update or not.

@echo.                                                                       >>%~dp0\output1.txt 2>&1
@echo Update complete. Finalizing log...
@hg log                                                                      >>%~dp0\output1.txt 2>&1

@echo.                                                                       >>%~dp0\output1.txt 2>&1

@echo.
@echo Done!                                                                  
pause