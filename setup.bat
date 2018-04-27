ECHO CREATING TASK...

SchTasks /Create /SC MINUTE /TN "Task" /TR %cd%\backup.bat

ECHO TASK CREATED!

pause

