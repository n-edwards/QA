1. Download and install Mercurial TortoiseHG.    http://mercurial.selenic.com/
   Open a command prompt, run command "hg config --edit" and enter your username. Save and close.
2. Copy QA_Exercise directory to C Drive. Inside is a Mercurial repository, Root, indicated by the .hg directory within.
3. In C:\QA_Exercise\Root\BuildProducts\Executable.Win64.txt, check that the current text is "old code."
4. Run C:\QA_Exercise\Root\CIS\CIS.bat. CIS.bat should create QA_Exercise\Root_Clone, and call for compilation there.
5. Compile.bat will copy source files into new text for cloned Executable.Win64.txt.
6. CIS.bat will then perform a diff, commit the change, push/commit it to Root, and update the root executable.
7. Back in C:\QA_Exercise\Root\BuildProducts\Executable.Win64.txt, check that the new text is "code1, code2."

8. Log should be created at C:\QA_Exercise\Root\CIS\output1.txt  (Best viewed with Notepad++ (http://notepad-plus-plus.org/download))
9. Most errors should be triggered by running Root's CIS.bat again. 
   Other errors require a new commit in Root, to make sure they are triggered in the clone:
     a. To test compilation failure, uncomment the check for SuccessfulBuild.txt. Run "hg commit -m "test"" command in Root. CIS.bat.
     b. To trigger error for missing compiler: Once you have a Root_Clone, change name of its Compile.bat. Run Root CIS.bat and skip past the clone failure (since you already have one).


Issues:
Cloning doesn't work if QA_Exercise isn't on C. Don't leave it in the downloads folder!
Tortoise commands will abort if a username hasn't been set.
  If notepad is not recognized on the command line, make sure your system environment variable PATH contains C:\Windows\System32;
If other Tortoise issues are encountered, try deleting the .hg folder, and reinitializing with commands in Root:
  hg init to create repository.
  hg add (adds everything to .hg tracking).
  hg commit (creates a note for initial commit).
Reboot after Tortoise install may be necessary, although this didn't seem to be the case in tests.

To reset the exercise after running CIS:
Delete output1.txt
Edit root Executable.Win64.txt to say "old code" again.
Delete Root_Clone.

---
References: 
  http://hgbook.red-bean.com/
  http://mercurial.selenic.com/guide
  http://mercurial.selenic.com/wiki
  http://www.selenic.com/mercurial/hg.1.html
  http://stackoverflow.com/
  http://www.robvanderwoude.com/batchfiles.php
  http://ss64.com/

